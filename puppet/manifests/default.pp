node 'Master.netbuilder.private' {
	include iansmith-java
}

node 'Agent001.netbuilder.private' {
	include iansmith-java
	#include maven
	#include git
}
