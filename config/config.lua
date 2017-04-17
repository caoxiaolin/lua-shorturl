return {
    -- domain
    domain = "http://www.shorturl.com/",
    
    -- if enable redis
    enable_redis = false,

    -- mysql config
    mysql = {
        conn = {
            host = "192.168.41.128",
            port = 3550,
            database = "shorturl",
            user = "root",
            password = "123456",
            timeout = 5000,
            max_packet_size = 1024 * 1024
        },
        timeout = 5000,
        pool = {
            -- 20s
            max_idle_timeout = 20000,
            -- connection pool size
            pool_size = 50
        }
    }
}
