Red [
    Title: "speech.red"
]

do https://redlang.red/authoring

user.app.speak:  function[.message [word! string!] /print][

    DEFAULT_RATE: 0
    ;-------------------------------------------------
    .rate: DEFAULT_RATE
    ;-------------------------------------------------
    message: replace/all .message "“" "" ; Cortana doesn't recognize "“"
    message: replace/all .message "”" "" ; Cortana doesn't recognize "”"
    rate: .rate
    ;-------------------------------------------------

    template: .to-powershell [ ; all . methods are defined in library
        {Add-Type -AssemblyName System.speech}
        {$speaker = New-Object System.Speech.Synthesis.SpeechSynthesizer}
        {$speaker.rate=<%rate%>}
        {$Speaker.Speak("<%message%>")}        
    ]

    powershell-command: .string.expand template [ ; .string.expand is defined in library
        message: (message)
        rate: (rate)
    ]
    
    .refresh-screen
    if print [system/words/print .message] ; since print is used as refinement one should call system/words/print
    .refresh-screen ; defined in library as .do-events/no-wait   
    call/wait powershell-command ; /wait waits for speak to finish sentence  
]

speak: :user.app.speak; speak is clone of user.app.speak method
say: :user.app.speak

say "I am Cortana."