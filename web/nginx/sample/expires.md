Expires
=====

    location ~* \.(rar|zip|doc|ppt|pdf|xls)$
    {
        expires      1d;
    }   
    location ~* \.(gif|jpg|jpeg|png|bmp|swf|ioc|flv|mp3|wma|wmv|mid)$
    {
        expires      1d;
    }   
    location ~* \.(htm|html|txt|xml)$
    {
        expires      1d;
    }   
    location ~* \.(js|css)$
    {
        expires      1h;
    } 