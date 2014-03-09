gulp       = require 'gulp'
jade       = require 'gulp-jade'
gutil      = require 'gulp-util'
mocha      = require 'gulp-mocha'
coffee     = require 'gulp-coffee'
stylus     = require 'gulp-stylus'
concat     = require 'gulp-concat'
uglify     = require 'gulp-uglify'
connect    = require 'gulp-connect'
imagemin   = require 'gulp-imagemin'

paths =
  views       : 'src/**/*.jade'
  styles      : 'src/styles/**/*.stylus'
  images      : 'src/images/**/*'
  scripts     : 'src/scripts/**/*.coffee'
  dest        : 'build'

gulp.task 'scripts', ->
  gulp.src(paths.scripts)
    .pipe(coffee())
    .pipe(uglify())
    .pipe(concat 'all.min.js')
    .pipe(gulp.dest paths.dest + '/scripts')
    .pipe(connect.reload())

gulp.task 'styles', ->
  gulp.src(paths.styles)
    .pipe(stylus())
    .pipe(gulp.dest paths.dest + '/styles')
    .pipe(connect.reload())

gulp.task 'images', ->
  gulp.src(paths.images)
    .pipe(imagemin())
    .pipe(gulp.dest paths.dest + '/images')

gulp.task 'views', ->
  gulp.src(paths.views)
    .pipe(jade())
    .pipe(gulp.dest paths.dest)
    .pipe(connect.reload())

gulp.task 'connect', connect.server
  open:
    browser  : 'safari'
  port       : 1337
  root       : [paths.dest]
  livereload : yes

gulp.task 'watch', ->
  gulp.watch paths.views,   ['views']
  gulp.watch paths.styles,  ['styles']
  gulp.watch paths.scripts, ['scripts']


gulp.task 'default', ['connect', 'views', 'styles', 'scripts', 'images', 'watch']
