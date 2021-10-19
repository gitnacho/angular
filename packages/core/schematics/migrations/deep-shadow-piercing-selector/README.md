## shadow-piercing selector `/deep/` to `::ng-deep`

Automatically migrates shadow-piercing selector from `/deep/` to `::ng-deep`.

#### Antes
```css
:host /deep/ * {
  cursor: pointer;
}
```

#### Después:
```css
:host ::ng-deep * {
  cursor: pointer;
}
```
