Red [
    Title: "TBC"
]

.readable-to-block: function [>readable-data][

    block>: copy []

    .readable-data: >readable-data

    title: select .readable-data 'Title ; extract title from .readable-data
    Sub-title: select .readable-data 'Sub-Title ; extract sub-title from .readable-data
    Paragraphs: select .readable-data 'Paragraphs ; extract all paragraphs from .readable-datas


    if none? Paragraphs [
        Paragraphs: copy []
        forall .readable-data [

            label: .readable-data/1
            value: .readable-data/2

            if block? value [
                if set-word? label [
                    append Paragraphs label
                    append/only Paragraphs value
                ]
            ]
        ]
    ]

    foreach [label content] Paragraphs [
        append block> label
        append/only block> select content '.links
    ]
    ??  block>

]

readable-to-block: :.readable-to-block

Favorites: [

    Title: {My Favorites}

    Main: [
        .title: {Main}
        .links: [
            github https://github.com/lepinekong?tab=repositories
            twitter https://twitter.com
            gitter https://gitter.im/red/help
        ]
    ]    
    Daily: [
        .title: {Daily}
        .links: [
            pragmatists https://blog.pragmatists.com
            Dzone https://dzone.com
            Devto https://dev.to/
            Redlang https://gitter.im/red/help
            dormoshe https://dormoshe.io/daily-news
            futurism https://futurism.com/
        ]
    ]
    Weekly: [
        .title: {Weekly}
        .links: [
            JSWeekly https://javascriptweekly.com
            MyBridge https://medium.mybridge.co/@Mybridge
        ]
    ]    

    Monthly: [
        .title: {Monthly}
        .links: [
            Codemag http://www.codemag.com/Magazine/AllIssues
            VSMag https://visualstudiomagazine.com/Home.aspx
            MSDN https://msdn.microsoft.com/en-us/magazine/msdn-magazine-issues.aspx
        ]
    ]
]

.readable-to-block Favorites
