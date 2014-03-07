gulp       = require 'gulp'
gutil      = require 'gulp-util'
mocha      = require 'gulp-mocha'
coffee     = require 'gulp-coffee'
stylus     = require 'gulp-stylus'
concat     = require 'gulp-concat'
uglify     = require 'gulp-uglify'
imagemin   = require 'gulp-imagemin'
livereload = require 'gulp-livereload'

paths =
  src:
    styles      : 'src/styles/**/*.stylus'
    images      : 'src/images/**/*'
    scripts     : 'src/scripts/**/*.coffee'
  dest:
    styles      : 'build/styles'
    images      : 'build/images'
    scripts     : 'build/scripts'

gulp.task 'scripts', ->
  gulp.src(paths.scripts)
    .pipe(coffee())
    .pipe(uglify())
    .pipe(concat 'all.min.js')
    .pipe(gulp.dest paths.scripts)

gulp.task 'styles', ->
  gulp.src(paths.styles)
    .pipe(stylus())
    .pipe(gulp.dest paths.styles)

gulp.task 'images', ->
  gulp.src(paths.images)
    .pipe(imagemin())
    .pipe(gulp.dest paths.images)

gulp.task 'watch-client', ->
  gulp.watch paths.scripts, ['client-scripts', 'styles']


gulp.task 'default', ['client-scripts', 'node-scripts', 'styles', 'images','watch-client', 'watch-server']
