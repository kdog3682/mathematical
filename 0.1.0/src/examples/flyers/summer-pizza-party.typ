#import "@local/typkit:0.1.0": *
#import "@local/magic:0.1.0"

#set page(
    margin: (
        left: 1.5in,
        right: 1.5in,
    ),
    background: image(
)
#set text(
    size: 1.5em
)

#magic.title([Summer End Pizza Party])

#magic.table(
    Location: [Sunset Park Basketball Court],
    Date: [Sunday August 18th, 2024],
    Time: [11:30AM to 1:30PM],
)

#v(20pt)

- Pizzas
- Chips
- Drinks

#align({
    [
        Tell your friends & family!

        *Come eat!*
    ]
}, center)

#let attrs = (
    width: 200pt,
    height: 150pt,
)
#stack(
    dir: ltr,
    image(english-baller, ..attrs), 
    image(chinese-baller, ..attrs),
)


#flip-to-bottom([

#magic.title([夏末披萨派对])

#magic.table(
    地点: [日落公园篮球场],
    日期: [2024年8月18日 星期日],
    时间: [上午11:30 到 下午1:30],
)

#v(20pt)

- 披萨
- 薯片
- 饮料

#align({
    [
        告诉你的朋友和家人！

        *来吃吧！*
    ]
}, center)

])

