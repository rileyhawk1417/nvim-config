local function front_matter_handler(note)
  -- This is equivalent to the default frontmatter function.
  local creation_date = tostring(os.date("%x %X"))
  local out = { id = note.id, aliases = note.aliases, tags = note.tags, date_created = creation_date }
  -- `note.metadata` contains any manually added fields in the frontmatter.
  -- So here we just make sure those fields are kept in the frontmatter.
  if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
    for k, v in pairs(note.metadata) do
      out[k] = v
    end
  end
  return out
end

local function note_id_generator(title)
  -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
  -- In this case a note with the title 'My new note' will be given an ID that looks
  -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
  -- NOTE: In my case not sure why the title doesnt work, so will use the alias
  local suffix = ""
  if title ~= nil then
    -- If title is given, transform it into valid file name.
    suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9_%-]", ""):lower()
  else
    -- If title is nil, just add 4 random uppercase letters to the suffix.
    for _ = 1, 4 do
      suffix = suffix .. string.char(math.random(65, 90))
    end
  end
  -- NOTE: dont like the default method so made it readable
  local date = tostring(os.date("%x"))
  local formatted_time = date:gsub("/", "_")
  return suffix .. "-" .. formatted_time
end

require("obsidian").setup({
  workspaces = {
    {
      name = "personal",
      path = "~/Documents/MarkDownNotes/personal",
    },
    {
      name = "public",
      path = "~/Documents/MarkDownNotes/public",
    },
  },
  completion = {
    nvim_cmp = true,
    min_chars = 2,
    --prepend_note_id = true,
    --prepend_note_path = false,
    ---use_path_only = false,
  },
  wiki_link_func = function(opts)
    if opts.id == nil then
      return string.format("[[%s]]", opts.label)
    elseif opts.label ~= opts.id then
      return string.format("[[%s|%s]]", opts.id, opts.label)
    else
      return string.format("[[%s]]", opts.id)
    end
  end,
  templates = {
    subdir = "Templates/ObsidianNvim",
    date_format = "%Y-%m-%d-%a",
    time_format = "%H:%M",
  },
  new_notes_location = "notes_subdir",
  note_id_func = note_id_generator,
  note_frontmatter_func = front_matter_handler,
})
