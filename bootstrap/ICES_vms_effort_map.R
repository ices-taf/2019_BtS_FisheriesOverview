

taf.library("icesVMS")

# icesVMS::update_token("colin")
vms_effort <- icesVMS::get_effort_map("Baltic Sea")

write.taf(vms_effort)
