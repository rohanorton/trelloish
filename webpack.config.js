const ExtractTextPlugin = require("extract-text-webpack-plugin");
const elmSource = __dirname + '/web/elm';
const bourbon = require("bourbon");
const neat = require("bourbon-neat");

module.exports = {
    entry: [
        './web/styles/app.scss',
        './web/static/js/app.js',
        './web/elm/Main.elm'
    ],
    output: {
        path: './priv/static/',
        filename: 'js/app.js'
    },
    module: {
        loaders: [
            {
                test: /\.elm$/,
                exclude: [/elm-stuff/, /node_modules/],
                loader: 'elm-webpack?cwd=' + elmSource
            }, {
                test: /\.js$/,
                exclude: /node_modules/,
                loader: 'babel',
                query: {
                    presets: ['es2015']
                }
            }, {
                test: /\.css$/,
                loader: ExtractTextPlugin.extract('style', 'css')
            }, {
                test: /\.scss$/,
                loaders: ['style', 'css', 'sass']
            }, {
                test: /\.(woff|woff2)(\?v=\d+\.\d+\.\d+)?$/, loader: 'url?limit=10000&mimetype=application/font-woff'
            }, {
                test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: 'url?limit=10000&mimetype=application/octet-stream'
            }, {
                test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: 'file'
            }, {
                test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: 'url?limit=10000&mimetype=image/svg+xml'
            }
        ],
        noParse: [/\.elm$/]
    },
    plugins: [
        new ExtractTextPlugin('css/app.css')
    ],
    sassLoader: {
        includePaths: []
            .concat(bourbon.includePaths)
            .concat(neat.includePaths)
    },
    resolve: {
        modulesDirectories: [
            'node_modules',
            __dirname + '/web/static/js'
        ],
        alias: {
            elm: __dirname + '/web/elm'
        },
        extensions: ['', '.scss', '.css', '.js', '.elm']
    }
};
