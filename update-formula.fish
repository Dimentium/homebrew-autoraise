#!/usr/bin/env fish
if test "$argv[1]" = ""
    echo Usage:
    echo update-formula 3.3
  else    
    set newVersion "$argv[1]"
    set newFile "v$newVersion.tar.gz"
    echo Trying to download $newFile
    wget -nv https://github.com/sbmpost/AutoRaise/archive/refs/tags/$newFile
    if test "$status" != "0"
        echo Fail!
      else
        echo Succes!\n
        echo Calculating sha256..
        set sha (sha256sum $newFile | string split " ")[1]
        echo $sha\n
        rm $newFile
        echo Old values:
        grep -E 'version |sha256 ' autoraise.rb
        echo Replacing with new values..
        sed -i '' -e '/version / s/\".*\"/\"'$newVersion'\"/ ; /sha256 / s/\".*\"/\"'$sha'\"/ ;' autoraise.rb
        if test "$status" = "0"
            echo New values:
            grep -E 'version |sha256 ' autoraise.rb
            echo \nSucces!
          else
            echo Fail!
        end
    end
end
