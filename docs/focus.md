# focus

Lightweight log functions to drive and track progress.

## log

Prefix communicates progress status of last item. 

> Note that _self approval_ means a poc or individual project. All collaborative work is reviewed.

Format of entries is `<timestamp> <prefix> <infix> <key>: <deliverable-key>: note`

| prefix | disposition |
|--------|----------|
| `<>` | Delivered / merged to master post review. |
| `{}` | Code pushed for review (or merged self approval). |
| `()` | Doc / memo distributed. |
| `[]` | Scope established/revised and distributed . |
| `..` | Progress |
| `><` | Path exhausted, going another direction. |
| `!!` | Blocked |
| `--` | Neutral or not applicable |

Infix communicates the transition, from the last cycle, the focus of this cycle represents:

| infix | transition type |
|-------|-----------------|
| `->` | New or intentional context switch |
| `>>` | Return to (append to `result` to drill in) |
| `<<` | Interrupt driven context switch |
| `--` | Result; finding, observation or conclusion. |

> `||` Initiate a background or async process (cannot be displayed in the table).

| key | description |
|-----|-------------|
|    ---    | - R & D -|
| `graph:`  | Refine concept graph. |
| `study:`  | Read, watch, annotate. |
| `scope:`  | Clarify/document requirements. |
| `arch:`   | Interrelate complex scopes. | 
|    ---    | - implementation -|
| `code:`   | For use by customer (internal or external). |
| `poc:`    | Implemented for demonstration; use grok if not shared. |
| `grok:`   | Implement/do to understand; includes replication, triage, etc. |
| `test:`   | Explicitly manual testing/exploration. |
| `hack:`   | For personal use. |
|    ---    | - collaboration -|
| `peer:`   | Direct collaboration on code. |
| `assist:` | Assist / unblock a colleague. |
| `pass:`   | Seek assistance from a colleague. |
| `review:` | Code review for a colleague. |
| `demo:`   | Prep for demos & presentations. (`sync:` to deliver)|
|    ---    | - communication -|
| `sync:`   | Meetings where S/N > 0.67. |
| `noise:`  | Meetings where S/N < 0.67. |
| `bcast:`  | Corp or Org driven meetings. |
| `docs:`   | Documentation, for users. |
| `memo:`   | Memorandum (email etc), for governance. |
|    ---    | - overhead -|
| `ops:`    | Dev / prod environment system admin. |
| `it:`     | Org origin system admin. |
| `corp:`   | Org origin process admin or overhead. |
| `admin:`  | Org origin admin, including HR. |
| `track:`  | Dev origin tracking admin. |
|    ---    | - SA - | 
| `horizon` | Scan/process new information; address, prioritize or discard. |
| `field`   | Review existing commitments and select focus. |
| `bearing` | Current location with respect to previously identified objectives. |
| `heading` | Identify objectives, priorities, at larger scale or longer timeline. |

## deliverables

### Legend
 
```
![] 1|1|- personal-key :: Description :: Org-key          # ToDo, high priority.
 <> 5|3|3 complex-task :: All the things :: MED-1234      # Completed, my estimate higher.
 <> 3|3|5 foo :: bar :: baz [08/16/19:08/23/19::08/21/19] # Commit:Slip:Complete
```
> note: Keep the keys as single tokens.

#### Points

`x:y:z` are points; mine, other's, retrospective. Use 1,2,3,5 and 8. 

> version 0.0.2
