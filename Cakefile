fs = require 'fs'
path = require 'path'
{exec} = require 'child_process'

SRC_DIR = './src'
ASSETS_DIR = './assets'
BUILD_DIR = './build'


mkdirIfNotExist = (dir)->
  fs.readdir dir, (err)->
    if err
      fs.mkdir dir

compileAll = (srcDir,distDir,callback)->
  coffee = exec "coffee -c -o #{distDir} #{srcDir}"
  coffee.stderr.on 'data',(data)->
    process.stderr.write data.toString()
  coffee.stdout.on 'data',(data)->
    process.stdout.write data.toString()
  coffee.on 'exit', (code)->
    callback?() if code is 0

copyAll = (srcDir,distDir,callback)->
  fs.readdir srcDir, (e,files)->
    for file in files
      com = exec "cp #{srcDir}/#{file} #{distDir}"
      com.stderr.on 'data',(data)->
        process.stderr.write data.toString()
      com.stdout.on 'data',(data)->
        process.stdout.write data.toString()
      com.on 'exit', (code)->
        callback?() if code is 0


removeAll = (dir,callback)->
  fs.readdir dir, (e,files)->
    if(e)
      return null
    for file in files
      com = exec "rm #{dir}/#{file}"
      com.stderr.on 'data',(data)->
        process.stderr.write data.toString()
      com.stdout.on 'data',(data)->
        process.stdout.write data.toString()
      com.on 'exit', (code)->
        callback?() if code is 0


task 'compile','compile src',->
  mkdirIfNotExist(BUILD_DIR)
  compileAll SRC_DIR,BUILD_DIR

task 'copy', 'copy assets',->
  mkdirIfNotExist(BUILD_DIR)
  copyAll ASSETS_DIR,BUILD_DIR

task 'clean','clean generated files',->
  removeAll BUILD_DIR

task 'build', 'build',->
  invoke 'compile'
  invoke 'copy'

task 'zip', 'zip build dir',->
  exec "zip build -j #{fs.readdirSync(BUILD_DIR).map((e)->"#{BUILD_DIR}/#{e}").join(" ")}"
