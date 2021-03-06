# Copyright Google LLC All Rights Reserved.
#
# Use of this source code is governed by an MIT-style license that can be
# found in the LICENSE file at https://angular.io/license
"""Angular integration testing
"""

load("//tools/npm_integration_test:npm_integration_test.bzl", "npm_integration_test")
load("@build_bazel_rules_nodejs//:index.bzl", "copy_to_bin")

# The @npm packages at the root node_modules are used by integration tests
# with `file:../../node_modules/foobar` references
NPM_PACKAGE_ARCHIVES = [
    "@angular/animations-12",
    "@angular/common-12",
    "@angular/core-12",
    "@angular/forms-12",
    "@angular/platform-browser-12",
    "@angular/platform-browser-dynamic-12",
    "@angular/platform-server-12",
    "@angular/router-12",
    "@babel/core",
    "@rollup/plugin-babel",
    "@rollup/plugin-node-resolve",
    "@rollup/plugin-commonjs",
    "check-side-effects",
    "core-js",
    "google-closure-compiler",
    "jasmine",
    "typescript",
    "rxjs",
    "systemjs",
    "tsickle",
    "tslib",
    "protractor",
    "terser",
    "puppeteer",
    "rollup",
    "rollup-plugin-sourcemaps",
    "webdriver-manager",
    "@angular/cli",
    "@angular-devkit/build-angular",
    "@bazel/bazelisk",
    "@types/jasmine",
    "@types/jasminewd2",
    "@types/node",
]

# The generated npm packages should ALWAYS be replaced in integration tests
# so we pass them to the `check_npm_packages` attribute of npm_integration_test
FRAMEWORK_PACKAGES = [
    "@angular/animations",
    "@angular/bazel",
    "@angular/benchpress",
    "@angular/common",
    "@angular/compiler",
    "@angular/compiler-cli",
    "@angular/core",
    "@angular/elements",
    "@angular/forms",
    "@angular/language-service",
    "@angular/localize",
    "@angular/platform-browser",
    "@angular/platform-browser-dynamic",
    "@angular/platform-server",
    "@angular/router",
    "@angular/service-worker",
    "@angular/upgrade",
    "zone.js",
]

def npm_package_archives():
    """Function to generate pkg_tar definitions for WORKSPACE yarn_install manual_build_file_contents"""
    npm_packages_to_archive = NPM_PACKAGE_ARCHIVES
    result = """load("@rules_pkg//:pkg.bzl", "pkg_tar")
"""
    for name in npm_packages_to_archive:
        label_name = _npm_package_archive_label(name)
        last_segment_name = name.split("/")[-1]
        result += """pkg_tar(
    name = "{label_name}",
    srcs = ["//{name}:{last_segment_name}__all_files"],
    extension = "tar.gz",
    strip_prefix = "/external/npm/node_modules/{name}",
    # should not be built unless it is a dependency of another rule
    tags = ["manual"],
)
""".format(name = name, label_name = label_name, last_segment_name = last_segment_name)
    return result

def _npm_package_archive_label(package_name):
    return package_name.replace("/", "_").replace("@", "") + "_archive"

def _angular_integration_test(name, **kwargs):
    "Set defaults for the npm_integration_test common to the angular repo"
    payload_size_tracking = kwargs.pop("payload_size_tracking", [])
    pinned_npm_packages = kwargs.pop("pinned_npm_packages", [])
    use_view_engine_packages = kwargs.pop("use_view_engine_packages", [])
    data = [
        # We need the yarn_bin & yarn_files available at runtime
        "@nodejs//:yarn_bin",
        "@nodejs//:yarn_files",
    ]

    # By default run `yarn install` followed by `yarn test` using
    # the bazel managed hermetic version of yarn inside
    DEFAULT_COMMANDS = [
        "patch-package-json",
        # Workaround https://github.com/yarnpkg/yarn/issues/2165
        # Yarn will cache file://dist URIs and not update Angular code
        "rm -rf ./.yarn_local_cache",
        "mkdir .yarn_local_cache",
        "$(rootpath @nodejs//:yarn_bin) install --cache-folder ./.yarn_local_cache",
        "$(rootpath @nodejs//:yarn_bin) test",
    ]

    commands = kwargs.pop("commands", [])
    if commands == "default":
        commands = DEFAULT_COMMANDS
    elif commands == "payload_size_tracking":
        commands = DEFAULT_COMMANDS + [
            "$(rootpath @nodejs//:yarn_bin) build",
            "$(rootpath //:scripts/ci/track-payload-size.sh) %s dist/*.js true ${RUNFILES}/angular/$(rootpath //goldens:size-tracking/integration-payloads.json)" % name,
        ]
        data = data + [
            "//goldens:size-tracking/integration-payloads.json",
            "//:scripts/ci/track-payload-size.sh",
            "//:scripts/ci/payload-size.sh",
            "//:scripts/ci/payload-size.js",
        ]

    # Complete list of npm packages to override in the test's package.json file mapped to
    # tgz archive to use for the replacement. This is the full list for all integration
    # tests. Any given integration does not need to use all of these packages.
    npm_packages = {}
    for pkg in NPM_PACKAGE_ARCHIVES:
        if pkg not in pinned_npm_packages:
            npm_packages["@npm//:" + _npm_package_archive_label(pkg)] = pkg
    for pkg in FRAMEWORK_PACKAGES:
        # If the generated Angular framework package is listed in the `use_view_engine_packages`
        # list, we will not use the local-built NPM package, but instead map to the
        # corresponding View Engine v12.x package from the `@npm//` workspace.
        if pkg in use_view_engine_packages:
            npm_packages["@npm//:" + _npm_package_archive_label("%s-12" % pkg)] = pkg
        else:
            last_segment_name = pkg.split("/")[-1]
            npm_packages["//packages/%s:npm_package_archive" % last_segment_name] = pkg

    npm_integration_test(
        name = name + "_test",
        check_npm_packages = FRAMEWORK_PACKAGES,
        commands = commands,
        npm_packages = npm_packages,
        tags = kwargs.pop("tags", []) + [
            # `integration` tag is used for filtering out these tests from the normal
            # developer workflow
            "integration",
            # Integration do not work inside of a sandbox as they may run host applications such
            # as chrome (which is run by ng) that require access to files outside of the sandbox.
            "no-sandbox",
            # Remote doesn't work as it needs network access right now
            "no-remote-exec",
        ],
        data = kwargs.pop("data", []) + data,
        # 15-minute timeout
        timeout = "long",
        # Tells bazel that this test should be allocated a large amount of memory.
        # See https://docs.bazel.build/versions/2.0.0/be/common-definitions.html#common-attributes-tests.
        size = "enormous",
        **kwargs
    )

def angular_integration_test(name, **kwargs):
    "Sets up the integration test target based on the test folder name"

    # Note: We copy the `package.json` file to the `bazel-bin` as otherwise
    # the actual source file `package.json` file would be modified on Windows.
    copy_to_bin(
        name = "%s_package_json" % name,
        srcs = ["%s/package.json" % name],
    )

    native.filegroup(
        name = "_%s_sources" % name,
        srcs = ["%s_package_json" % name] + native.glob(
            include = ["%s/**" % name],
            exclude = [
                "%s/package.json",
                "%s/node_modules/**" % name,
                "%s/.yarn_local_cache/**" % name,
            ],
        ),
    )
    _angular_integration_test(
        name = name,
        test_files = kwargs.pop("test_files", "_%s_sources" % name),
        **kwargs
    )
