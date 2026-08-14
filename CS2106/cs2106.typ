#import "@preview/boxed-sheet:0.1.2": *
//#import "../src/lib.typ": *

#set text(font: (
  "Times New Roman",
  "SimSun",
))


#let homepage = link("https://kiritowu.github.io/")[https://kiritowu.github.io/]
#let author = "Zhao Wu"
#let title = "MA1521 Cheat Sheet, AY25/26 S2"

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