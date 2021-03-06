use MooseX::Declare;

=head2


NOTES

	NOW	- USE SSH TO PARSE LOGS AND PERFORM SSH COMMANDS
	
	LATER - USE QUEUES:
	
		WORKERS REPORT STATUS TO MANAGER
	
		MANAGER DIRECT WORKERS TO:
		
			- DEPLOY APPS
			
			- PROVIDE WORKFLOW STATUS
			
			- STOP/START WORKFLOWS


=cut

use strict;
use warnings;

class Test::Mock::Exchange extends Exchange {

#####////}}}}}

use Conf::Yaml;
use Ops::Main;

#### Strings
has 'mocking'		=>  ( isa => 'Bool', is => 'rw', default	=>	1 );

#### Arrays
has 'outputs'		=>  ( isa => 'ArrayRef|Undef', is => 'rw', default	=>	sub { return [] } );
has 'inputs'		=>  ( isa => 'ArrayRef|Undef', is => 'rw', default	=>	sub { return [] } );

use FindBin qw($Bin);
use Test::More;

#####////}}}}}

method notifyStatus ($data) {
	push @{$self->inputs()}, $data;
	$self->returnOutput();
}

method getSampleLines {
	$self->returnOutput();
}

method getWorkAssignment ($state) {
	$self->returnOutput();
}

method latestVersion ($package) {
	$self->returnOutput();
}

method change ($uuid, $state) {
	$self->logDebug("uuid", $uuid);
	$self->logDebug("state", $state);
	
	push @{$self->inputs()}, {
		uuid	=>	$uuid,
		state	=>	$state
	};
	
}

method returnOutput {
	return splice($self->outputs(), 0, 1);
}


}