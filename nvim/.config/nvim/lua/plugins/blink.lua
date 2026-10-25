return {
    'saghen/blink.cmp',
    version = '1.*', -- prebuilt fuzzy matcher binary
    opts = {
        completion = {
            -- select without inserting
            list = { selection = { auto_insert = false } },
        },
        signature = { enabled = true },
    },
}
