class TreeviewsController < ApplicationController

  def index
  end

  def get_dir_list
    root_flg = (params["root"] == "source") ? true : false
    path = "/home/sora/work/treeview_test"
    path = params["root"] unless root_flg
    arry = []
    d = dir_list(path, arry)
logger.info(d)
    render :json => arry || [], :layout => false
  end

protected
  def dir_list(path, arry=[], root_flg=false)
    Dir.glob("#{path}/*").map do |d|
      classes = "file"
      classes = "folder" if FileTest.directory?(d)
      hasChildren = (FileTest.directory?(d)) ? true : false
    	h = {"id" => d, "text" => File.basename(d), "path" => File.dirname(d), "expanded" => false, "classes" => classes, "hasChildren" => hasChildren, "children" => []}
      arry << h
    end
    arry
  end

end
