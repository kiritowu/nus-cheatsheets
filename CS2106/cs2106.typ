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
  #inline[What is OS?]

  *OS* is a program that acts as an *intermediary* between a *computer user* and the *computer hardware*. (Simplified definition)

  - E.g.
    - Windows, Mac OS, Linux, Solaris, FreeBSD
    - iOS, Android
    - PS5, Xbox, Nintendo
    - Smart TV, Smart Watch
  
  #inline[Brief History of OS]
  1. First computer:
    - *OS Type*: No OS
      - Program directly interacts with hardware.
      - Reprogram by physically changing configuration of hardware (cable, switches, punched paper type)
    - *Advantage*:
      - Minimal overhead due to OS
    - *Disadvantage*:
      - Not portable (to port, need manually rewrite the program)
      - Inefficient use of computer?
    - E.g. Electronic Numerical Integrator And Computer (ENIAC), Harvard Mark I
  2. Mainframes
    - *Characteristics*:
      - No interactive interface (program via paper tape, magnetic tape, punch card)
      - Batch Processing Only
    - *OS Type*: Batch OS
      - User still interact with hardware directly
      - Additional information for OS (e.g. resource required, job specification)
    - *Advantage*:
      - Execute user program (ie Job) one at a  time
    - *Disadvantage*
      - Simple batch processing is inefficient as CPU idle when I/O.
      - Multiprogramming is absent.
    - E.g. IBM 360
    #image("images/w1/batch-os.png", width: 40%)
  3. Time-Sharing OS
    - *OS Type*: Time-Sharing OS
    - *Advantage*:
      - Allow multiple users to interact with machine using terminals (teletypes)
      - User job scheduling (illusion of concurrency)
      - OS manages CPU time, memory and storage
      - Virtualization of hardware (each program executes as if it has all the resources to itself)
    - E.g. Apple II PC, IBM PC

    #image("images/w1/time-machine-os.png", width: 50%)
  4. Personal OS
    - Windows model:
      - Single user at a time, but possibly more than 1 user can access
      - General time-sharing model
    - Unix model:
      - One user at workstation but other users can access remotely
      - General time sharing model
]
== Motivation of OS
#concept-block[
1. *Abstraction*

  - Hide low-level details and present higher-level functionality to user
  - Motivation:
    - Large variation in hardware configuration, but same hardware has well defined functionality. (E.g. rotation speed for hard disk varies but it can stores and retrieve information)
  - Efficiency, Programmability and Portability
2. *Resource Allocator*
  - Manage all resources (CPU, Memory, IO) and Arbitrate potentially conflicting request for efficient and fair resource use
  - Motivation:
    - Program requires multiple hardware resources to run.
    - Multiple programs should run simultaneously for better utilization
3. *Control Program*
  - Control execution of programs to:
    - Prevent errors and improper use of computer
  - Motivation:
    - Program may "misuse" the computer
      - Bugs (accident), Virus, Malware (malicious)
    - Multiple user can share the computer
  - Security, isolation and protection
4. *Portability and Efficiency*
]
== OS Structures
#concept-block[
  #inline[High-Level View of OS]
  - OS is a software that runs in *Kernel Mode* (i.e. Direct access to All hardware resources)
    - Can't use system calls in kernel code
    - Can't use normal libraries and I/O
  - Other software operates in *User Mode*  (i.e. Limited/Controlled access to hardware resources)

  #image("images/w1/os-components.png")

  #inline[OS Structures]
  1. *Monolithic*
    - Big program (e.g. Linux source-code)
    - If Kernel fails, BSOD
    - Better performance
    #image("images/w1/monolithic-kernel.png", width: 70%)
  
  2. *Microkernel*
    - Smaller and cleaner abstraction
    - Provide basic and essential facilities:
      - Inter-Process Communication
      - Address space management
      - Thread management
    - Higher-level OS services are run outside of the kernel, using IPC to communicate.
    - Lower performance
  #image("images/w1/microkernel-kernel.png", width: 60%)
]

== Virtual Machines
#concept-block[
  *Virtual Machine* emulates the underlying hardware, created and managed by *Hypervisor* (aka *Virtual Machine Monitor (VMM)*)

  1. Type 1 Hypervisor
  #image("images/w1/type-1-hypervisor.png")

  2. Type 2 Hypervisor 
  #image("images/w1/type-2-hypervisor.png") 
]

= Process Abstraction
#concept-block[
#inline[Motivation]
- Allowing only one program to run at a time is inefficient, so OS enables multiple programs to run concurrently.
- To switch between programs, the OS needs to save the context of the current program and load the context of the next program.
- A *process* (or task or job) is the OS abstraction for a running program.
]
== Process Context
#concept-block[

To allow multiple programs to run concurrently, the OS needs to track the context of each program. This includes:

#table(
  columns: (auto, auto, 1fr),
  inset: 2.5pt,
  stroke: 0.3pt,
  align: left,
  table.header([*Layer*], [*Component*], [*Stores*]),
  table.cell(rowspan: 4, align: horizon)[Memory],
  [Instructions], [program code],
  [Data], [globals + static],
  [Stack], [frames (calls + locals)],
  [Heap], [dynamically allocated data],
  table.cell(rowspan: 4, align: horizon)[Hardware],
  [GPRs], [temporary data],
  [PC], [next instruction address],
  [SP], [top of stack],
  [FP], [base of current frame],
  table.cell(rowspan: 2, align: horizon)[OS],
  [PID], [unique process ID],
  [Process State], [current process state],
)
]

== Stack Memory & Function Calls

#concept-block[
  #inline[Stack Memory]
  - The *stack* is a region of memory used to support function calls.
  - Each function invocation pushes a new stack frame onto the stack, while each function return pops the top stack frame.
  - Each stack frame contains (CS2106 convention, caller-pushed first):

  #table(
    columns: (auto, auto, 1fr),
    inset: 2.5pt,
    stroke: 0.3pt,
    align: left,
    table.header([*Component*], [*Who*], [*Why*]),
    [Arguments (only those that don't fit in registers)], [Caller], [so the callee can read its inputs],
    [Return address (saved PC)], [Caller], [return to the right instruction after the callee returns],
    [Saved old FP], [Callee], [restore the caller's FP before returning],
    [Saved old SP], [Callee], [restore the caller's SP (pop this frame)],
    [Saved callee-saved GPRs], [Callee], [only GPRs the callee modifies; protect the caller's values across the call],
    [Local variables], [Callee], [space for the callee's own variables],
  )

  - The stack pointer (SP) points to the top of the stack
  - The frame pointer (FP) points to the base of the current stack frame
  - We use a frame pointer as stack pointer tracks the current top of the stack, which can move as local variables are pushed and popped. The FP is fixed so we can use fixed offset to access the arguments and local variables.
  - Restoring the SP does not erase the stack frame, so it is important to always initialise local variables as uninitalised local variables can contain leftover values from previous calls.
  #inline[Register Spilling]
  - *Register Spilling*: When a function has more arguments than the number of registers, the extra arguments are spilled to the stack
  - Even if neither functions are short of registers, the caller and caller may end up using the same registers, so we need to save the registers and restore them after the call.
  - There are two methods to save the registers:
    - *Callee-saved*: the callee saves the old values of the registers into its stack frame and restores them after the call
    - Caller-saved: the caller saves needed registers into its stack frame and restores them after the call
  - CS2106 convention: all registers are callee-saved unless otherwise specified
  #inline[Function Calls]
 Function invocation differs depending on the hardware and software. But in CS2106, we use the following convention:
  1. *Function Call Preparation*:
    1. Caller: pass parameters using register and/or stack
    2. Caller: save return program counter onto stack
  2. *Transfer of Control from Caller to Callee*:
    1. Callee: *save registers used by callee, saves the old frame pointer*, saves the old stack pointer
    2. Callee: allocate space for local variables of the callee on stack
    3. Callee: adjust stack pointer to point to the new stack top, *adjust the frame pointer*
  3. *Callee Function Executes* (during that time, the callee may invoke other functions, but this can be abstracted away)
  4. *Callelee Function Returns*
    1. Callee: place return result in register (if applicable, usually a dedicated return register)
    2. Callee: *restore saved registers and frame pointer*, restore saved stack pointer
  5. *Transfer of Control from Callee back to Caller using saved PC*:
    1. Caller: utilises return result (if applicable)
    2. Caller: continues execution of program

  #image("images/w2/stack-frame.png")

]

== Heap Memory

#concept-block[
  #inline[Heap Memory]
  - The *heap* is a region of memory used to store dynamically allocated data.
  - Dynamically allocated data in C: `malloc` and `free`
  - Dynamically allocated data cannot be stored in:
    - Data region: the size of the data is known at compile time
    - Stack: data may outlast the function call
  - Heap management is harder than stack management as allocation and deallocation can happen in arbitary orders, leading to fragmentation.
]

== Process States

#concept-block[
  #inline[Process State Model]
  #image("images/w2/state-process-model.png")

  - A process can be in one of the following states:
    - *New*: process has been created but not fully initialised/admitted to the system
    - *Ready*: process is waiting to execute
    - *Running*: process is currently executing
    - *Blocked*: process is waiting for an event to occur (e.g. I/O completion, signal)
    - *Terminated*: process has finished execution
  
  #inline[Multi-Process Management]
  - With one CPU core, at most one process can be running at a time
  - With $m$ CPU cores, at most $m$ processes can be running at a time
  - CS2106 convention: assume one CPU core unless otherwise specified
  - Different processes may be in different states at the same time

  #inline[Process Queues]

  #image("images/w2/process-queues.png")

  - The OS maintains a queue of processes for each state
    - *Ready Queue*: processes that are ready to be scheduled to run on the CPU
    - *Blocked Queue*: processes that are waiting for an event to occur
  - More than one process can be in the ready and blocked queues at the same time
  - There may be separate queues for different types of blocked processes (e.g. I/O blocked, signal blocked)
]