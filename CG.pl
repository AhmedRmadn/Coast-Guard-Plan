:- include('KB.pl').

situation([XAgent,YAgent,ShipsList,CapacityAgent],s0):-agent_loc(XAgent,YAgent),ships_loc(ShipsList),capacity(CapacityAgent).

situation([XAgent,YAgent,ShipsList,CapacityAgent],result(A,S)):-
	(situation([XAgentPrev,YAgentPrev,ShipsListPrev,CapacityAgentPrev],S),grid(N,M)),
	
	(
	
	(
	(ShipsList=ShipsListPrev,CapacityAgent=CapacityAgentPrev),
	(
	(A=up,
	  YAgent=YAgentPrev,XAgent is XAgentPrev-1,XAgentPrev - 1>=0);
	(A=down,
	  YAgent=YAgentPrev,XAgent is XAgentPrev+1,XAgentPrev + 1<N);
	(A=left,
	  XAgent=XAgentPrev,YAgent is YAgentPrev-1,YAgentPrev - 1>=0);
	(A=right,
	  XAgent=XAgentPrev,YAgent is YAgentPrev+1,YAgentPrev + 1<M)
	 )
	 );
	 
	 (
	 
	 (XAgent=XAgentPrev,YAgent=YAgentPrev),
	 (
	 
	(A=pickup,
	  CapacityAgentPrev>0,select([XAgentPrev,YAgentPrev],ShipsListPrev,ShipsList),
	  CapacityAgent is CapacityAgentPrev-1);
	  
	(A=drop,
	  XAgent=XAgentPrev,YAgent=YAgentPrev,ShipsList=ShipsListPrev,capacity(MaxCapacity),
	  CapacityAgentPrev<MaxCapacity,station(XAgentPrev,YAgentPrev),CapacityAgent=MaxCapacity)
	 
	 )
	 
	 )
	 
	 
	 ).



   


ids(X,L):-
   (call_with_depth_limit(X,L,R), number(R));
   (call_with_depth_limit(X,L,R), R=depth_limit_exceeded,
    L1 is L+1, ids(X,L1)).
	
goal(S):-
   ids((capacity(MaxCapacity),situation([_,_,[],MaxCapacity],S)),1).
   
   
