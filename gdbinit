define st
    shell tmux new -d st-util
    target remote localhost:4242
end

define nrf
    shell tmux new -d JLinkGDBServer -if swd -speed 4000 -device $(nrfjprog --deviceversion | sed 's/_REV.*//') -nogui -singlerun
    target remote localhost:2331
end

define reload
    python gdb.execute("make -j32 " + os.path.basename(gdb.objfiles()[0].filename))
    load
    monitor reset
    continue
end

python import freertos_gdb
python import os
set print pretty on
