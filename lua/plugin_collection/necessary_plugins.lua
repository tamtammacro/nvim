return {
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
    {
      "christoomey/vim-tmux-navigator",
      cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
      },
    }
}
