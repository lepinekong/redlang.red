Red [
    Title: "compare-files.red"
]

unless value? '.redlang [
    do https://redlang.red
]
.redlang [to-file]

.compare-checksum: function [
    >file1 
    >file2
][
    >file1: .to-file >file1
    >file2: .to-file >file2
    file1-content: read >file1
    checksum-file1: checksum file1-content 'SHA256
    file2-content: read >file2
    checksum-file2: checksum file2-content 'SHA256 
    return (checksum-file1 = checksum-file2)  
]

compare-checksum: :.compare-checksum
