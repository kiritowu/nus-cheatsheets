#import "@preview/boxed-sheet:0.1.2": *
//#import "../src/lib.typ": *

#set text(font: (
  "Times New Roman",
  "SimSun",
))


#let homepage = link("https://kiritowu.github.io/")[https://kiritowu.github.io/]
#let author = "Zhao Wu and Tien Cheng"
#let title = "CS2106 Cheatsheet, AY26/27 S1"

#let my-colors = (
  rgb(190, 149, 196),
  rgb("#f39f71"),
  rgb(102, 155, 188),
  rgb(229, 152, 155),
  rgb("6a4c93"),
  rgb("E0A500"),
  rgb("#934c84"),
  rgb("#934c5a"),
)

#show: boxedsheet.with(
  title: title,           // Title of document
  homepage: homepage,     // Homepage of author
  authors: author,        // Author Name
  write-title: true,      // Writes Title on the first page
  title-align: left,      // Position of titles in concept box
  title-number: true,     // Whether to numbered the title (Default = true)
  title-delta: 2pt,       // Fonts delta for title scaling (Default = 1pt)
  scaling-size: false,    // Whether to scale the titles (Default = false)
  font-size: 5.5pt,       // Size of font (Default = 5.5pt)
  line-skip: 5.5pt,       // Size of line-skip (Default = 5.5pt)
  x-margin: 10pt,         // Margin on x-axis (Default = 30pt)
  y-margin: 30pt,         // Margin on y-axis (Default = 0pt)
  num-columns: 4,         // Number of columns (Default = 5)
  column-gutter: 2pt,     // Space between columns (Default = 4pt)
  numbered-units: false,  // Numbering of units (Default = false)
  color-box: my-colors    // Color scheme of boxes
)

= Introduction

#concept-block[
  *OS* is an *intermediary program* between *computer hardware* and *user*.
  #table(
    columns: (0.7fr, 2fr, 1fr),
    stroke: 0.5pt,
    [First Computer],
    table.cell(colspan: 2)[
    *OS Type*: No OS
      - Program directly by physically changing the hardware configuration (cables, switches, punched paper tape)
    *Advantage*:
      - Minimal OS overhead
    *Disadvantage*:
      - Not portable (to port, need to manually rewrite the program) and Inefficient
    - E.g. Electronic Numerical Integrator And Computer (ENIAC), Harvard Mark I
    ],
    [ Mainframes ],
    [
      *OS Type*: Batch OS
        - Execute one job at a time.
        - Support batch processing only
        - No interactive interface (program via paper tape, magnetic tape, punch card)
        - User interacts with hardware directly with additional information for OS (e.g. resource required, job specification)
      *Disadvantage*:
        - CPU is idle during I/O from simple batch processing
      - E.g. IBM 360
    ],[
      #image("images/w1/batch-os.png", width: 100%)
    ],
    [
      Time-Sharing OS
    ],
    [
   *OS Type*: Time-Sharing OS
    *Advantage*:
      - Allow multiple users to interact with the machine using terminals (teletypes)
      - User job scheduling (illusion of concurrency)
      - OS manages CPU time, memory and storage
      - Virtualization of hardware (each program executes as if it has all the resources to itself)
    - E.g. Apple II PC, IBM PC
    ],
    [
      #image("images/w1/time-machine-os.png", width: 100%)
    ],
    [
      Personal OS
    ],
    table.cell(colspan: 2)[
    Machine may be dedicated to user, not timeshared between users
    Windows model:
      - Single user at a time, but possibly more than 1 user can access
    Unix model (General time-sharing model):
      - One user at the workstation, but other users can access remotely
    ],
  )
#inline[Motivation of OS]
1. *Abstraction*: Hide low-level details and present higher-level functionality to the user
  // - Motivation:
  //   - Large variation in hardware configuration, but the same hardware has well-defined functionality. (E.g. hard disk rotation speed varies, but it can store and retrieve information)
  // - Efficiency, Programmability and Portability
2. *Resource Allocator*: Manage all resources (CPU, Memory, I/O) and arbitrate potentially conflicting requests for efficient and fair resource use
  // - Motivation:
  //   - Program requires multiple hardware resources to run.
  //   - Multiple programs should run simultaneously for better utilisation
3. *Control Program*: Control execution of programs to prevent errors and improper use of the computer
  // - Motivation:
  //   - Program may "misuse" the computer
  //     - Bugs (accident), Virus, Malware (malicious)
  //   - Multiple users can share the computer
  // - Security, isolation and protection
]
== OS Structures
#concept-block[
  - OS is software that runs in *Kernel Mode* with direct access to all hardware resources (w/o system calls, normal libraries and 'normal' I/O in kernel mode)
  - Other software operates in *User Mode* (i.e. limited/controlled access to hardware resources)

  #image("images/w1/os-components.png", width: 100%)
  
  #inline[OS Structures]
  #table(
    columns: (0.7fr, 1.5fr, 1.5fr),
    stroke: 0.5pt,
    [Monolithic],
    [
      - Big program (e.g. Linux source code)
      - If Kernel fails, BSOD
      - Better performance
    ],
    [
      #image("images/w1/monolithic-kernel.png", width: 100%)
    ],
    [Microkernel],
    [
      - Smaller and cleaner abstraction
      - Provides basic and essential facilities:
        - Inter-Process Communication
        - Address space management
        - Thread management
      - Higher-level OS services are run outside of the kernel, using IPC to communicate.
      - Lower performance
    ],
    [
      #image("images/w1/microkernel-kernel.png", width: 100%)
    ],
  )
]

== Virtual Machines
#concept-block[
  A *Virtual Machine* emulates the underlying hardware for running multiple OS, created and managed by a *Hypervisor* /  *Virtual Machine Monitor (VMM)*

  #table(
    columns: 2,
    stroke: 0.5pt,
    [Type 1 Hypervisor], [Type 2 Hypervisor],
    [#image("images/w1/type-1-hypervisor.png")],
    [#image("images/w1/type-2-hypervisor.png")]
  )
]

= Process Abstraction
#concept-block[
- *Process* is the OS abstraction for a running program.

#inline[Process Context]
#table(
  columns: (auto, auto, 1fr),
  inset: 2.5pt,
  stroke: 0.3pt,
  align: left,
  table.header([*Layer*], [*Component*], [*Stores*]),
  table.cell(rowspan: 4, align: horizon)[Memory],
  [Text], [program instructions],
  [Data], [global variables and static variables],
  [Stack], [collection of stack frames],
  [Heap], [region of memory used to store dynamically allocated data],
  table.cell(rowspan: 4, align: horizon)[Hardware],
  [General-Purpose Registers (GPRs)], [temporary data],
  [Program Counter (PC)], [next instruction address],
  [Stack Pointer (SP)], [top of stack frame address],
  [Frame Pointer (FP)], [fixed location in stack frame],
  table.cell(rowspan: 2, align: horizon)[OS],
  [Process ID (PID)], [unique process ID],
  [Process State], [current process state],
)
]

== Memory & Function Calls
#concept-block[
  - Each function invocation *pushes* / return *pop* a new *stack frame onto the stack*.
  - *FP* points to the fixed location in stack frame, allowing access with constant offset.

  #table(
    columns: (auto, auto, 1fr),
    inset: 2.5pt,
    stroke: 0.3pt,
    align: left,
    table.header([*Stack-Frame Component*], [*Who*], [*Why*]),
    [Local variables], [Callee], [Callee's own local variables],
    [Parameters (only those that don't fit in registers)], [*Caller*], [so the callee can read the parameters of function call],
    [Saved GPRs], [Callee], [Copy of GPRs which callee modifies; protect the caller's values across the call],
    [Saved old SP], [Callee], [restore the caller's SP],
    [Saved old FP], [Callee], [restore the caller's FP],
    [Return address / Saved PC], [*Caller*], [return to the right instruction after the callee returns],
  )


  #inline[Function Call Convention]
  #table(
    columns: (2fr, 1.5fr),
    stroke: 0.3pt,
    [
  1. *Function Call Preparation*:
    1. Caller: pass *parameters using registers and/or the stack*
    2. Caller: save *return PC on stack*
  2. *Transfer of Control from Caller to Callee*:
    1. Callee: save *registers used by the callee, old SP and FP*
    2. Callee: allocate space for *local variables of the callee on the stack*
    3. Callee: adjust the *SP (and FP) to point to the new stack top*
  3. *Callee Function Executes*
  4. *Callee Function Returns*
    1. Callee: save *return result in return register* (if applicable)
    2. Callee: *restore saved registers and SP, FP*
  5. *Transfer of Control from Callee back to Caller using saved PC*:
    1. Caller: Use return result and continues execution of the program
    ],
    [
  #image("images/w2/stack-frame.png")
  + Return Value
    ]
  )

  #inline[Register Saving and Spilling]
  - *Register Saving*: caller and callee may use the same registers, so we need to save the registers and restore them after the call.
  - *Register Spilling*: When a function has more arguments than the number of registers, the extra arguments are spilled to the stack
    - *Callee-saved* (default 2106 convention): the callee saves the old values of the registers into its stack frame and restores them after the call
    - *Caller-saved*: the caller saves needed registers into its stack frame and restores them after the call
  - *Stack Frame Deallocation*: doesnt guarantee removing of previous values
  
  #inline[Heap Memory]
  - *heap* is a memory region to store dynamically allocated memory. (e.g. `malloc` and `free` in C)
  - Dynamically allocated data *cannot be stored in*:
    - *Data region*: size must be known at compile time
    - *Stack*: the data may outlast the function call
]

== Process States
#concept-block[
  #inline[Process State Model]
  #align(center)[
  #image("images/w2/state-process-model.png", width: 70%)
  ]

  - Voluntarily give up cpu: running $->$ ready
  - Context switch: ready $->$ running

  // - A process can be in one of the following states:
  //   - *New*: process has been created but not fully initialised/admitted to the system
  //   - *Ready*: process is waiting to execute
  //   - *Running*: process is currently executing
  //   - *Blocked*: process is waiting for an event to occur (e.g. I/O completion, signal)
  //   - *Terminated*: process has finished execution
  
  #inline[Multi-Process Management]
  - With 1 CPU core, at most 1 process can be running at a time (without threading)
  - With $m$ CPU cores, at most $m$ processes can be running at a time

  #inline[Process Queues]

  // #align(center)[
  // #image("images/w2/process-queues.png", width: 65%)
  // ]

  - The OS maintains a queue of processes for each state
    - *Ready Queue*: processes that are ready to be scheduled to run on the CPU
    - *Blocked Queue*: processes that are waiting for an event to occur
      - may be separate queues for diff types of blocked (e.g. I/O / signal blocked)
]
== Process Control Block (PCB)
#concept-block[
A *Process Control Block (PCB)* or *Process Table Entry* is a data structure that *describes the execution context* for a *process*, maintained by kernel.

#align(center)[
#image("images/w3/pcb.png", width: 70%)
]
]

== System Calls
#concept-block[
  *System Call* is a synchronous *OS API* for a *user program to request services* in Kernel.

  // #inline[Difference in OS]
  // - Unix Variant:
  //   - Follows POSIX standards
  //   - Small number of calls
  // - Windows Variant:
  //   - Uses `Win` API across different Windows versions
  //   - New version of windows add more calls.
  //   - Huge number of calls

  #inline[System Call Mechanism]
  1. User invokes the library call (e.g. `getpid()`)
  2. Library call places the system call number into a register.
  3. Library call invokes the *trap instruction to switch from user mode to kernel mode*.
  4. In kernel mode, the *dispatcher identifies the system call* and *passes control to the appropriate system call handler*.
  5. System call handler executes the system call
  6. System call handler ended by restoring CPU state and return to user mode.
  7. Library call returns the result to the user program.

  #inline[Exception and Interrupt]
  - *Exception*: Occurs due to program execution, synchronous
    - E.g. divide by zero error or a page fault
  - *Interrupt*: Occurs independent of program execution, asynchronous
    - E.g. hardware interrupt or a software interrupt
]

== A Case Study of Processes in Unix
// #concept-block[
// #inline[Process Abstraction]
// Unix process management centres on `fork()`, `exec()`, `exit()`, and `wait()`.

// In Unix, an entry in the PCB consists of:
//   1. Identification:
//     - PID: Process ID (integer identifier)
//   2. Information:
//     - Process State: Running, Sleeping/Suspended, Stopped, Zombie, etc.
//     - Parent PID (PPID)
//     - Cumulative CPU time
//     - Other accounting and resource-management information

// Use `ps` (process status) to inspect process information; `man ps` for options.
// ]

=== Process Creation: Fork -> Exec
#concept-block[
// #inline[Unix vs Windows]
// - *Windows*: spawn a new process in (pretty much) a single syscall — path, arguments, etc.
// - *Unix*: Two-step approach:
//   1. Parent calls `fork()` clones the current process (parent continues from the instruction after `fork()`)
//   2. Child calls `exec()` to replaces the current process (child discards old text/data/stack and execution state).

#inline[`fork()`]
*`int fork()`* creates a child process by duplicating currently executing parent.

- Both parent and child continue from *immediately after* the `fork()` call.
- Child is initially an *almost exact duplicate*:
  - Same code and *initial* address-space *contents* (conceptually duplicated, *not* shared)
  - Copied register and execution context
  - Different PID and PPID
  - Different `fork()` return value: parent receives the child's PID; child receives `0`

#inline[Nondeterministic scheduling]
- Parent/child order is *nondeterministic*: parent first, child first, or interleaved.

#inline[Independent Address Spaces]
Parent and child initially *see equivalent values* after `fork()`, but do *not* share memory.
- Stack, heap, data, and code image are *conceptually duplicated*.
- Modifying a variable in one process does *not* modify the other.
-  Shared kernel resources are inherited (e.g. opened files), not the address space.

#inline[`exec()` replaces the process image]
`exec()` *replaces* the current process (code and data) with a new executable:
- Begins at the new program's entry point
- Discards the old stack and execution state
- *Retains the same PID* and broader process identity
- *Successful `exec()` does not return* — the old image no longer exists
- Variants: `execl(full path, arg0, ..., NULL)`, `execv(“/bin/ls”, args)`, `execve`, `execlp(relative path, arg0, ..., NULL)`, `execvp`

#inline[`main` Command-Line Arguments]
`int main(int argc, char **argv[], char **vp)`
- `argc`: number of arguments, *including* the program name
- `argv`: array of C strings arguments; `argv[0]` is conventionally the executable name
- `vp`: array of C strings environment variables

#inline[`init` and Process Tree]
A process can only be created by forking an existing process, so Unix processes form a *process tree*.
- Root is *init*: created by the kernel during boot, traditionally *PID 1*
- Common ancestor of user processes; typically spawns OS/system programs
- Adopts orphaned processes
- *Cannot be killed* even though it runs in user space; if it crashes → *kernel panic*
]

=== Process Termination & Lifecycle
#concept-block[
#inline[`exit()`]
*`exit(int status)`* terminates the current process. *Does not return*.
- *exit status*: zero if normal/successful termination, non-zero if error/abnormal 
- Returning from `main()` *implicitly* invokes `exit()` with return value becomes the exit status

- On process `exit()`:
  - Process state is set to *Zombie*
  - Most resources are released (e.g. file descriptors)
  - Some information is *not releasable*, so the parent can `wait()`, Eg: PID, Exit status, Process accounting (e.g. CPU time)

#inline[`wait()`]
*`pid_t wait(int *status)`* lets a parent synchronise with any child(s):
- *Blocks* until at least one child terminates
- Returns the PID of a terminated child
- Stores the child's exit status through `status`, else `NULL`
- Kernel can write into the parent's memory because it is privileged
- Variants:
  - `waitpid()` — wait for a specific child
  - `waitid()` — wait for child state changes

#inline[Zombie vs Orphan]
- *Zombie*: child that has *exited* but *has not yet been consumed* by parent via `wait()`
  - Occupies a process-table entry; too many can exhaust the table (older Unix: may need reboot)
- *Orphan*: a *still-running* child whose *parent has terminated*
  - `init` becomes its pseudo-parent
  - When the child later terminates, `init` will clean up with `wait()`
  - If the parent dies while the child is *already a zombie*, `init` reaps that leftover state too

// #inline[Parent–Child Lifecycle]
// 1. Parent `fork` a child
// 2. Child optionally `exec` a new program
// 3. Child `exit` and becomes a zombie
// 4. Parent `wait`
// 5. Kernel removes the child's remaining process-table entry

#inline[Unix Process States]
#align(center)[
#image("images/w3/process-state-diagram.png", width: 60%)
]
]

= Process Scheduling
#concept-block[
*Concurrent processes* execute during the same period:
- *Virtual parallelism:* pseudo-parallelism.
- *Physical parallelism:* multiple CPUs/cores execute processes in parallel.

*Time slicing* interleaves processes' instructions and requires a *context switch* at each handover. It works on *single core* (slice instructions) or *multiple processors* (slice instructions and cores).

#inline[Scheduling]
// #inline[Scheduling Problem]
The *scheduler* uses a *scheduling algorithm* to choose the next process:

// Scheduling Algorithm is tailored based on process behaviour and process environment.
// - *Process Behavior:* a typical process cycles between
//   1. CPU-activity: Compute-bound spends majority of time
//   2. IO-activity: IO-bound spends majority of time
// - *Processing Environment:*
//   1. Batch Processing: No interaction required, no need to be responsive.
//   2. Interactive (or Multiprogramming): Active user interacts with system. Should be responsive.
//   3. Real time processing: Have deadline to meet, usually periodic process.

// For all processing environments:
// - *Fairness*: Processes should get a fair share of CPU time and no starvation
// - *Utilization*: All parts of computing system should utilized

// Scheduling Algorithms:
- *Non-preemptive (cooperative):* runs until it blocks or voluntarily yields the CPU.
- *Preemptive:* runs for a fixed quota, then is suspended.
]

== Scheduling for Batch Processing
#concept-block[
Batch systems have *no user interaction* and mainly use *non-preemptive scheduling*.

*Criteria:*
- *turnaround time* = finish - arrival
- *throughput* = tasks finished per unit time
- *waiting time* = total time waiting since creation
- *CPU utilization* = percentage of time the CPU runs a task.

#inline[First Come First Serve (FCFS)]
Uses a *FIFO queue*. Its head runs until *completion or blocking*; a blocked task leaves the queue and rejoins its *tail* when ready.
- *Traits:* *non-preemptive, no starvation.*
- *Costs:* the *convoy effect* prevents CPU- and I/O-bound processes from running concurrently; *reordering* tasks can lower average waiting time.
// #image("images/w4/fcfs.png", width: 60%)

#inline[Shortest Job First (SJF)]
Non-preemptively selects the task with the *smallest total CPU time*.
- Requires *advance knowledge* of each task's total CPU time.
- *Minimizes average waiting time*, but its bias toward short jobs can *starve long jobs*.
// #image("images/w4/sjf.png")

#inline[Predicting CPU Time]
Estimate the next CPU-bound phase from previous phases:
$
  "Predicted"_(n+1) = alpha "Actual"_n + (1-alpha) "Predicted"_n
$
$"Actual"_n$: most recent CPU time; $"Predicted"_n$: past estimate; $alpha$: weight on the recent event; $"Predicted"_(n+1)$: new estimate.

#inline[Shortest Remaining Time (SRT)]
Preemptively runs the job with the *shortest remaining (or expected) time*; a newly arrived shorter job *preempts* the running job.

// #image("images/w4/srt.png")
]
== Scheduling for Interactive Environment
#concept-block[
Interactive systems mainly use a *periodically invoked, preemptive scheduler* for good *response time* and *predictability*.

*Response Time*: First CPU time - time task creation 

#inline[Timer & Time Quantum]
- *Timer interrupt interval (ITI):* interval between interrupts that invoke the OS scheduler; typically *1–10 ms*.
- *Time quantum:* process execution allowance; a *multiple of the ITI*, constant or process-dependent, typically *5–100 ms*.

// #image("images/w4/iti-time-quantum.png")

#inline[Round Robin (RR)]
*Preemptive FCFS* using a *FIFO queue*. Its head runs until its *quantum expires, it finishes, or it blocks*; an unfinished task rejoins the tail, as does a blocked task once ready.
- *Timer interrupts* detect quantum expiry.
- *Wait bound:* $(n-1)q$ before getting the CPU, for $n$ tasks and quantum $q$.
- *Large $q$:* higher CPU utilization, longer waits. *Small $q$:* more overhead, shorter waits.

// #image("images/w4/round-robin.png")

#inline[Priority Based]
Runs the task with the *highest priority value*.
- *Preemptive:* a higher-priority arrival preempts a lower-priority running process.
- *Non-preemptive:* a late higher-priority arrival waits for the next scheduling round.
- *Starvation:* low-priority processes may never run. Mitigate by *lowering the running process's priority* after each quantum, or *excluding it from the next round* after giving it a quantum.
- *Priority Inversion:* H priority task is blocked by L priority task, who will never get scheduled as M priority task is in the way.
// #image("images/w4/priority-scheduling.png")

#inline[Multi-Level Feedback Queue (MLFQ)]
*Higher priority wins; equal priorities use RR.* New job -> highest priority, Deplete time quantum -> priority decrease, Job gives up -> priority maintained. This minimizes *response time for I/O-bound* processes and *turnaround time for CPU-bound* processes.

- Constantly spawning child before time quantum exceeds
- Bias for IO heavy task, CPU heavy task may starve

// #image("images/w4/mlfq.png")

#inline[Lottery Scheduling]
Distribute *lottery tickets* for resources (CPU time, I/O devices). At each decision, *randomly choose* an eligible ticket; in the long run, *X% of tickets gives X% resource use*.
]

= Inter-Process Communication
#concept-block[
  *Inter-Process Communication* transfers information between processes.

#inline[Shared-Memory]
 A *shared memory* region $M$ is created(`shmget`) and attached(`shmat`) by the processes $P_1$ and $P_2$, enabling communication.

  // *Advantages*:
  - Efficient: OS only needs to Create and Attach memory region
  - `shm[0]` to declare if the value is ready
  - `shmget` to create, `shmat` to attach, `shmdt` to detach and `shmctl` to destroy
  // - Ease of use: information of any type or size can be written easily in shared memory space

  // *Disadvantage*:
  // - Synchronization between resources is harder
// ```c
// #include <stdio.h>
// #include <stdlib.h>
// #include <sys/shm.h>

// int main() {
//   int shmid, *shm;

//   // Use shmget syscall to create a shared memory in
//   // IPC_PRIVATE: Create a new, private segment that only related processes (e.g. parent/child after fork) can share by passing around this shmid.
//   // Create the segment if it doesn’t exist, with Unix permissions 0600 — owner can read and write, nobody else can.
//   shmid = shmget(IPC_PRIVATE, 3 * sizeof(int), IPC_CREAT | 0600 );
//   // Exit if Memory cannot be created
//   if (shmid == -1) exit(1);

//   // Attach memory by initializing the pointer
//   // NULL: Let kernel choose free virtual address
//   // 0: no extra flag, default read/write access
//   shm = (int*) shmat(shmid, NULL, 0);
//   // Exit if memory cannot be attached
//   if (shm == (int*) -1) exit(1);

//   // Declare value not ready;
//   shm[0] = 0;
//   // Sleep while the value is ready
//   while(shm[0] == 0) {
//     sleep(3);
//   }

//   for (int i=0; i<3; i++) {
//     printf("Read %d from shared memory. \n", shm[i+1]);
//   }

//   // Detach and destroy shard memory region
//   shmdt( (char*) shm);
//   shmctl(shmid, IPC_RMID, 0);

//   return 0;
// }

// ```

  #inline[Message Passing]
  Process $P_1$ prepare messages $M$(stored in *kernel memory space*) and send to $P_2$ using *system calls*. Requires extra properties like Name and Synchronization.

  // *Advantages*:
  // - Portable: can be implemented on diff processing environment
  // - Easier Synchronization: when sync primitives is used, sender and receiver are implicitly synchronized

  // *Disadvantage*:
  // - Inefficient: Requires OS intervention
  // - Extra Copying

//  #image("images/w5/message-passing.png", width: 80%)
  - *Direct Communication*: Sender and Receiver 1-1 message explicitly name the other party (ie. unix domain socket). `Send/Receive( P1, Msg )`
  - *Indirect Communication*: Messages are sent / received from many-many message storage known as mailbox or port (i.e. unix message queue).  `Send/Receive( MB, Msg )`
  - *Blocking Primitives (synchronous)*: Receiver is blocked until message has arrived.
  - *Non-Blocking Primitives (asynchronous)*: Receiver either receive the message if available or some indication that message is not ready.
]

== Unix Pipes and Signals
#concept-block[
  A process has 3 default communication channels: stdin (`scanf`), stdout (`printf`), stderr. Declared in bash with "|".

  `int pipe(int fd[])` functions as circular bounded byte buffer (*writers wait when buffer is full*) and implicit synchronization (*readers wait when buffer is empty*)
  - Returns -1 if creation of fd fails
  - Returns EOF if read from an empty pipe with no writer

  Steps for creating a pipe:
  - `pipe(fd[2])` creates an array of file descriptor with `READ_END=0`, `WRITE_END=1`.
  - process may `write(fd[WRITE_END], str, strlen(str)+1)` or `read(df[READ_END], buf, sizeof(buf))`
  - `dup2(fd[0], STDID_FILENO)` and `dup2(fd[1], STDOUT_FILENO)`

  Redirecting `printf` to `STDOUT`:
  1. `close(STDOUT);`
  2. `open("file.txt", O_WRONLY | OCREATE | OTRUNC, 0644);`


// ```c
// #define READ_END 0
// #define WRITE_END 1

// int main()
// {
//   int pipeFd[2], pid, len;
//   char buf[100], *str = "Hello There!";

//   pipe( pipeFd );

//   if ((pid = fork()) > 0) { /* parent */
//     close(pipeFd[READ_END]);
//     write(pipeFd[WRITE_END], str, strlen(str)+1);
//     close(pipeFd[WRITE_END]);
//   } else { /* child */
//     close(pipeFd[WRITE_END]);
//     len = read(pipeFd[READ_END], buf, sizeof(buf));
//     printf("Proc %d read: %s\n", pid, buf);
//     close(pipeFd[READ_END]);
//   }
// }
// ```

#inline[Unix Signal]
  `signal` sent to a process using an *asynchronous* notification regarding an event.

  - Eg. Kill, Interrupt, Stop, Continue, Memory Error, Arithmetic Error...
  - `kill -9` (ie SIGKILL) cannot be captured with user-define handler
  - Signal handler cannot wait or signal a semaphore as it is not async safe

//   ```c
// #include <stdio.h>
// #include <signal.h>
// #include <unistd.h>

// void myOwnHandler( int signo )
// {
//   if (signo == SIGSEGV){
//     printf("Memory access blows up!\n");
//     exit(1);
//     }
// }

// int main()
// {
//   int *ip = NULL;

//   if (signal(SIGSEGV, myOwnHandler) == SIG_ERR)
//     printf("Failed to register handler\n");

//   *ip = 123;

//   return 0;
// }
// ```
]
== Threads
#concept-block[
  Multiple *threads* run concurrently in a process, sharing the *same memory context* (e.g. text, data, heap) and *OS context* (PID and other resources), *differing* only in *hardware context* (registers and stack).
  
  #inline[User and Kernel Thread]
  - *User Thread* is thread implemented as user library and handles by its runtime process, not aware by kernel.
    - Pros: More configurable and portable as thread operation are just library calls.
    - Cons: Scheduling performed at process level (1 thread blocks out whole process); cannot exploit multiple CPU.
  - *Kernel Thread* is thread implemented by OS, handled as system calls, enabling thread-level scheduling.
    - Pros: More than 1 thread in same process can run on multiple CPUs as it is handled by Kernel
    - Cons: Thread operation with system call (higher overhead), and generally less flexible.
  - *Hybrid Thread* uses both user thread and kernel thread at the same time.
]

= Synchronization
#concept-block[
  Concurrent execution is *non-deterministic*, so a *race condition* occurs when the outcome depends on the *order of shared-resource access/modification*.

  *Critical section (CS)* is code segment that only one process may execute at a time with the following properties
  - *Mutual Exclusion*: Only one processes can executes CS.
  - *Progress*: If no process in CS, one of the waiting processes is granted access.
  - *Bounded Wait*: Upperbound time for $P_1$ in CS, before other process can enter.
  - *Independence*: Process in non-CS should never block other process.

  Outcome of incorrect CS implementation:
  - *Deadlock*: All processes blocked and stops exeecution
  - *Livelock*: Result of deadlock avoidance mechanism, where processes keep changing state and make no progress
  - *Starvation*: Some proccesses are blocked forever

  #inline[Low-Level Implementation: TestAndSet]

  `TestAndSet Register, MemoryLocation` loads the content from memory to register, and stores 1 to memory, happens on hardware level (atomic).

  ```c
  EnterCS(int* Lock) while (TestAndSet(Lock) == 1) // Loop -> unlock
  ExitCS(int* Lock) *Lock=0; // Set lock to 0
  ```

  #inline[Higher level Language: Peterson's Algorithm]
  #align(center)[
    #image("images/w6/peterson.png", width: 50%)
  ]

  #inline[Higher level synchronization: Semaphore]
  Sempahore is an integer $S >= 0$, represent number of jobs that can run concurrently (counting semaphore).
  `mutex` when $S in {0,1}$ 
    - `Wait(S)`: When S==0, blocks and puts process to sleeping queue. Else, S-- (`P()`, `Down()`)
    - `Signal(S)`: Wakes up 1 sleeping processes if any. Else, S++ (`V()`, `Up()`)

  $
   N_(C S) = \#"Signal"("S") - \#"Wait"("S") quad S_"current" = 1 + N_(C S),quad  N_(C S) <= S_"initial"
  $

]