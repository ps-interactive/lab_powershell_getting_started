#run on DC01
$x = 1
$dir = "c:\Demos\SharedDirectory"
New-item -ItemType dir -Path $dir
cd c:\
New-SmbShare -Path $dir -FullAccess "Administrators" -ReadAccess "everyone" -Name SharedDirectory
do {
    $subdir = "$x-100"
    New-Item -ItemType Directory -Name $subdir -Path $dir
    New-Item -ItemType File -Name $x"-100.xlsx" -Path $dir\$subdir
    New-Item -ItemType File -Name $x"-100.docx" -Path $dir\$subdir
    New-Item -ItemType File -Name $x"-100.PNG" -Path $dir\$subdir
    New-Item -ItemType File -Name $x"-100.pdf" -Path $dir\$subdir
    $x ++
    } while ($x -le 5)

    