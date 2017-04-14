return {
    -- domain
    domain = "http://www.shorturl.com/",
    
    -- if enable redis
    enable_redis = true,

    -- mysql config
    mysql = {
        host = "192.168.41.128",
        port = 3550,
        dbname = "shorturl",
        user = "root",
        passwd = "123456",
        timeout = 5000,
        max_packet_size = 1024 * 1024        
    },

    -- mysql pool config
    mysql_pool = {
        -- 20s
        max_idle_timeout = 20000,
        
        -- connection pool size
        pool_size = 50
    }

}
