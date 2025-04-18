def --env FuzzyCd [pattern:string] {
    mut buildPath = "."
    for path in ($pattern | str downcase | str replace "\\" "/" --all | split row "/") {
        if $path ==  "" {
            continue
        }
        if $path like "^\\.+$" {
            $buildPath = $buildPath + "/" + ($path | split chars  | skip 1 | each {".."} | str join "/")
            continue
        }
        let exactMatch = ls $buildPath | where {|s| ($s.name | path basename | str downcase) == $path}
        if ($exactMatch | length) == 1 {
            $buildPath = $exactMatch | get name
        } else {
            let fuzzyMatch = ls $buildPath | where {|s| ($s.name | path basename | str downcase) like $path}
            if ($fuzzyMatch | is-empty) {
                print $"No match found for: ($path)"
                break
            }
            if ($fuzzyMatch | length) == 1 {
                $buildPath = $fuzzyMatch | first | get name
            } else {
                let nextLevel = $fuzzyMatch | input list "Choose the next folder" --fuzzy | get name
                $buildPath = $nextLevel
            }
        }
    }
    cd $buildPath
}
