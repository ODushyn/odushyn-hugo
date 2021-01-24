---
author: "O. Dushyn"
date: 2020-01-25 
description: "Pragmatic Programmer"
title: "My favourite tips from 'The Pragmatic Programmers' book"
menu:
  main:
    parent: books
---

20 years ago were published a currently well known
book ["The pragmatic Programmer"](https://www.amazon.com/Pragmatic-Programmer-Journeyman-Master/dp/020161622X). This is
one of not many books which is still relevant after 20 years, and some recommendations from there would probably never
become outdated.

20 years later since first publication world can enjoy the second edition of the book. Outdated information and code
examples are updated to nowadays reality. The core ideas of the book stayed tha same, though.

The book is build as 100 tips for becoming a better(pragmatic) programmer with explanations and examples. I want to
share my favorite ones.

- Care about your craft

  Basically, there is no point to develop software unless you care about doing it well.

- Don't leave with broken windows

  This one is probably my favourite. Don't leave "broken windows"(bad designs, wrong decisions, or poor code)
  unrepaired. The "Broken Window Theory": an abounded car stayed for a week untouched. But once a single window was
  broken, the got stripped and turned  
  upside down within hours.

- Remember the big picture.

  Only by keeping in mind big picture of the project we can come up with comprehensive improvements. You should
  constantly review what's happening around, not just what you are personally doing.
  
- Invest regularly in your knowledge portfolio
  
  An investment in knowledge always pays the best interest (Benjamin Franklin).

- English is just another programming language

  You are communicating only if you are conveying what you mean to convey - just talking isn't enough.
  Be a listener: if you want people listen to you - listen to them.
  Get back to people: always respond to emails and voicemails.
  
- Good design is easier to change than bad design 

  ETC principle: Easier to Change. It is almost never possible to build the right design and architecture from first attempt.
  Requirements may change or new better ideas may come up on the way. The way to keep agile is writing code is easy to change.
  Easy to change code means you don't need to refactor whole system to change its small logical part.
  Most people assume that maintenance begins when an application is released, that maintenance means fixing bugs and enhancing features.
  Authors of the book believes that those people are wrong. Maintenance is a continuous process starting from the first dat of development.

- Iterate the schedule with the code
  
  It is never easy to make an estimate, especially the accurate one. 
  
  What to say when asked for an estimate? - I'll get back to you.
  
  Take some time, probably divide estimation into 3: optimistic. realistic, pessimistic. Reevaluate your estimation together with project iterations.
  
- Always use version control
 
  Yes, even for home and "throw away" projects.
  
- Fix the problem, not the blame.

  It does not really matter the bug is your fault or someone else's. It is still your problem.

- "select" is not broken

  "select" here mean SQL *select* statement. The example was that developer believed that his code is working right but what working wrong was 
  select sql statement. Of course, it was opposite. It just took some time to find the real issue.
  Take some break or ask somebody else for a review - "select" is not broken.
  
- Tell, don't ask / Don't chain method calls
  
  ```
  amount = customer.orders.last().totals().amount;
  ``` 
  
  Doing this way may spread the knowledge about customer's orders throughout the system and create extra coupling.
  Better to encapsulate: 
  
  ```  
  customer.lastOrder().totalAmount
  ```
  
- Programming is about code, but programs about data

  What is the most of the programs is doing in the end is transforming data from some initial state to desired target state.
  Keeping in mind a high picture of data transformations helps to understand and improve the overall program.
  
- Don't pay inheritance tax

  Avoid using inheritance. Prefer composition or mixins instead.

- Shared state is incorrect state

  Try to avoid shared states, otherwise it becomes a hell once you want to apply parallelism.

- Don't program by coincidence

  If you've made some code to work and don't understand why it does - investigate and only after you do understand - move forward.

- Testing is not about finding bugs

  Testing is about preventing bugs, improving code and your understanding about the program. 

- Build End-to-End, not Top-Down or Bottom Up

  Build software incrementally by building small pieces of end-to-end functionality.

- Test you software, or your users will

  Testing, design, coding - it is all programming.

- Name well; Rename when needed.

  Name functions by `why it does it` and not `what it does`.
  Prefer `applyDiscount(Percentage amount)` instead of `deductPercent(amount)`.
  
- Programmers help people understand what they want

  Yep, programmers are not just writing code on their own.

- Agile is not a noun; Agile is how you do things

      1. workout where you are
      2. make the smallest meaningful step towards where you want to be
      3. evaluate where you end up and fix everything you broke
      4. repeat until you are done

- Find bugs once

  The same bug must not be seen twice. Once bug is caught - cover it with a test.

The last tip in the book was: "It is your life. Share it. Celebrate it. Build it, AND HAVE FUN!"


I really enjoyed reading the book and reflecting on the go. Highly recommend reading this book to all programmers with any level if you haven't done that yet.
