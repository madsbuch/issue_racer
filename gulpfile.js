/*
|--------------------------------------------------------------------------
| Gulp Dependencies
|--------------------------------------------------------------------------
|
| Run the following command to install all the necessary dependencies:
|
  "npm install gulp gulp-plumber gulp-ruby-sass gulp-autoprefixer gulp-minify-css gulp-uglify gulp-coffee gulp-rename gulp-concat gulp-imagemin gulp-notify gulp-livereload gulp-phpunit gulp-util tiny-lr"
|
| There is a chance you need to install with "sudo" depending on how you've
| set up your development environment.
*/

var gulp         = require('gulp'),
    sass         = require('gulp-ruby-sass'),
    autoprefixer = require('gulp-autoprefixer'),
    minifycss    = require('gulp-minify-css'),
    uglify       = require('gulp-uglify'),
    coffee       = require('gulp-coffee'),
    rename       = require('gulp-rename'),
    concat       = require('gulp-concat'),
    imagemin     = require('gulp-imagemin'),
    notify       = require('gulp-notify'),
    livereload   = require('gulp-livereload'),
    phpunit      = require('gulp-phpunit'),
    gutil        = require('gulp-util'),
    plumber      = require('gulp-plumber'),
    lr           = require('tiny-lr'),
    server       = lr();

// Assets paths
var paths =
{
  styles    : ['app/assets/*.scss'],
  scripts   : ['app/assets/*.coffee']
};


/*
|--------------------------------------------------------------------------
| SASS
|--------------------------------------------------------------------------
|
| Compiles the app.scss file found in
| app/assets/sass/, creating an app.min.css file
| in the public/assets/css/ folder and signals LiveReload
| to update the current page's styling.
|
*/

gulp.task('styles', function() {
  return gulp.src( paths.styles )
  .pipe(sass({ style: 'expanded' }))
  .pipe(autoprefixer('last 2 version', 'safari 5', 'ie 9', 'ios 6', 'android 4'))
  .pipe(rename({ suffix: '.min' }))
  .pipe(minifycss())
  .pipe(gulp.dest('public/assets/css/'))
  .pipe(livereload(server))
  .pipe(notify({ message: 'Styles compiled and minified...' }));
});


/*
|--------------------------------------------------------------------------
| Coffeescript
|--------------------------------------------------------------------------
|
| Compiles the app.coffee file found in
| app/assets/coffeescript/, creating an app.min.js file
| in the public/assets/js/ folder and signals LiveReload
| to update the current page.
|
| Note: Gulp Watch can suddenly die out if you make errors in your
| coffeescript file, stopping the watch process. If this happens
| simply run "gulp watch" in your terminal to restart watching.
|
*/

gulp.task('scripts', function() {
  return gulp.src(paths.scripts)
  .pipe(coffee({bare: true})
    .on('error', gutil.log)
    .on('error', gutil.beep)
  )
  .pipe(rename({ suffix: '.min' }))
  //.pipe(uglify())
  .pipe(gulp.dest('public/assets/js/'))
  .pipe(livereload(server))
  .pipe(notify({ message: 'Scripts compiled and minified...' }));
});


/*
|--------------------------------------------------------------------------
| Watch
|--------------------------------------------------------------------------
|
| Handles watching all specified file changes in your project.
| also signals LiveReload to update views within app/views/.
|
*/

gulp.task('watch', function() {
  server.listen(35729, function (e) {

    if (e) { return console.log(e) };

    gulp.watch(paths.styles,    ['styles']);
    gulp.watch(paths.scripts,   ['scripts']);

  });
});

gulp.task('default', ['styles','scripts','watch']);