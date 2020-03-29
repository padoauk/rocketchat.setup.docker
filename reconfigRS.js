cfg = rs.config()
cfg.members[0].host = "mongo4chat:27017"
rs.reconfig(cfg, {force: true})
