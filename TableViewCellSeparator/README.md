# What is TableViewCellSeparator?
TableViewCellSeparator provide a solution for custom cell separator without adding imageView or other traditional method.

TableViewCellSeparator use _UIBezierPath_ for cell separator.

# How to use TableViewCellSeparator?

For full length bottom separator
```objective-c
[cell addFullBottomSeparatorWithColor:[UIColor redColor] andLineWidth:1];
```

For full length top separator
```objective-c
[cell addFullTopSeparatorWithColor:[UIColor redColor] andLineWidth:1];
```

For custom start point of separator
```objective-c
[cell addBottomSeparatorWithColor:[UIColor redColor] andLineWidth:1 andX:10];
```

For calculating cell height at runtime
```objective-c
[cell getCellHeightForText:@"ABC" andAttributeDictionary:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} andTotalHorigontalSpaceing:20 andTotalVerticalSpaceing:20];
```