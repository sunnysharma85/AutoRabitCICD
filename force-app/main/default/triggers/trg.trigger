trigger trg on Opportunity (before insert,before update) {
system.debug(trigger.isinsert);

system.debug(trigger.new.size());

system.debug(trigger.isupdate);

for(opportunity o:trigger.new){
system.debug(o);


}

}