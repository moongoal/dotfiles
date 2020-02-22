" Default command options
const g:project_exec_options_default = {}

" Execute a command in a terminal.
" 
" Arguments:
"   cmd - The command to execute in a new terminal window
"   ... - A single optional argument specifying the arguments to pass to
"   term_start()
"
" Return:
"   The buffer index of the running terminal as returned by term_start().
function s:Exec(cmd)
    let args = #{ cwd: g:project_dir }
    let args = get(g:project_exec_options, a:cmd, args)
    let cmd = substitute(a:cmd, '{BUILD_TYPE}', g:project_build_type, 'g')

    if a:0 == 1
        call extend(args, a:1)
    endif

    return term_start(cmd, args)
endfunction

" Register a project.
"
" Only one project can be in the registered state at once.
" Once a project is registered, the :Project* commands exported by this script
" will operate on that project.
" 
" Arguments:
"   proj_dir - The project directory (will be set as default folder for
"   commands)
"   cmd_cfg - Configuration command
"   cmd_build - Build command
"   cmd_test - Test command
"   cmd_clean - Clean command
function project#Register(proj_dir, cmd_cfg, cmd_build, cmd_test, cmd_clean)
    let g:project_dir = a:proj_dir

    let g:project_commands = {
        \ "config": a:cmd_cfg,
        \ "build": a:cmd_build,
        \ "test": a:cmd_test,
        \ "clean": a:cmd_clean
        \ }
endfunction

" Unregister a previously registered project.
function project#Unregister()
    let g:project_build_type = "Debug"
    let default_cmd = "echo no active project"

    let g:project_commands = {
        \ "config": default_cmd,
        \ "build": default_cmd,
        \ "test": default_cmd,
        \ "clean": default_cmd
        \ }

    let g:project_exec_options = copy(g:project_exec_options_default)
endfunction

" Configure commands' options.
"
" Arguments:
"   options - A Dictionary where the keys are commands (as passed to
"   project#Register()) and the values are instances of Dictionary containing
"   the options to pass to term_start().
"
" Example:
"   let myOptions = #{ make: #{ cwd: "/tmp" } }
"
"   project#Register("configure", "make", "make test", "make clean")
"   project#ConfigureCommands(myOptions)
"
"
"   The given example will run "make" within /tmp but not "make test" or "make
"   clean" (let alone "configure").
function project#ConfigureCommands(options)
    let options = g:project_exec_options

    call extend(options, a:options)
endfunction

" Set initial state
call project#Unregister()

" Project commands
command ProjectConfigure call s:Exec(g:project_commands['config'])
command ProjectBuild call s:Exec(g:project_commands['build'])
command ProjectTest call s:Exec(g:project_commands['test'])
command ProjectClean call s:Exec(g:project_commands['clean'])
