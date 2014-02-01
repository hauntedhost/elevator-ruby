## cab logic:
* when a cab claims a remote call, that becomes its primary destination
* after a cab claims a remote call as its primary destination, that cab can claim additionals remote calls as long as: 1. the remote call's direction is the same as the cab's current direction, 2. the remote call's floor is >= the cab's current_floor and 3. the remote call's floor is < the cab's primary destination floor
* a cab will also queue all unique internal floor requests. it will stop at each internally requested floor that occurs en route to its primary destination. upon reaching its primary destination, a cab prioritizes its next direction 1. first, on the direction of the primary destination, 2. if there is no direction specified in the primary destination (e.g., the cab arrived at this floor as a result of an internal floor request), then the direction priority is based on the direction of the first-made internal floor request --- *to be continued ...*

---
## machine room
* [x] 1. creates a ``cab_call_queue``
* [x] 2. creates one or more ``cab_call_units`` for each floor, and passes the queue to each [x] ... these will sent the queue ``cab_call objects``
* [x] 3. creates ``cabs`` and passes the queue [x] ... cabs will listen to queue and take calls
* [? ] 4. create a ``cab_operation_panel``
* [? ] 5. create ``cab_shafts`` and pass them cabs
* [?] 6. create a cab bank and pass it ``cab_shafts`` (that may or may not have ``cabs``)
