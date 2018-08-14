Red [
    Title: "compare-checksum.red"
]

.compare-checksum: function [>file1 >file2][
    file1-content: read >file1
    checksum-file1: checksum file1-content 'SHA256
    file2-content: read >file2
    checksum-file2: checksum file2-content 'SHA256 
    return (checksum-file1 = checksum-file2)  
]

if not value? 'compare-checksum [
    compare-checksum: :.compare-checksum
]

