module.exports = {
    // publicPath: '/dist',
    devServer: {
        proxy: {
            '/apis': {
                target: 'http://127.0.0.1:8000/', // target host
                // ws: true, // proxy websockets 
                changeOrigin: true, // needed for virtual hosted sites
                pathRewrite: {
                    '^/apis': '' // rewrite path
                }
            },
        }
    },
    // css: {
    //     loaderOptions: {
    //         sass: {
    //             // data: `@import "~@/assets/sass/main.scss";`
    //             prependData: `@import "~@/assets/sass/main.scss";`
    //         }
    //     }
    // }
}