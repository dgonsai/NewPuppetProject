node 'Master.netbuilder.private' {
	include java
	include maven
	include git
}

node 'Agent001.netbuilder.private' {
	include java
	include maven
	include git
}
