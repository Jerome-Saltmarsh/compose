// The Compose Language
// Apply class to all children
// Easy and fun to write
// Easy to read

[
    x-start-center( padding: 20 ) [
            ( text: 'hello world 1' color: 'red' size: 12 )
            { text: 'hello world 2' color: 'blue' size: 15 }
            { text: 'hello world 3' color: 'green' size: 17 }
    ]
]