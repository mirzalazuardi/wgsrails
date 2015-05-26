require 'roo'
class ArticlesController < ApplicationController
  before_action :check_current_user, only: [:new, :create, :edit, :update, :destroy]
  def index
    #@articles = Article.all
    @articles = Article.paginate(:page => params[:page], :per_page => 3)
    #@articles = Article.status_active 
  end

  def export
    @articles = Article.all
    respond_to do |format|
      format.xlsx
    end
  end

  def process_file
    #debugger
    raise 'Nothing to import' unless params[:file].present?

    total_row = 0
    spreadsheet = open_spreadsheet(params[:file])

    spreadsheet.sheets.each_with_index do |sheet, index|
      spreadsheet.default_sheet = spreadsheet.sheets[index]

      header = Array.new
      spreadsheet.row(1).each { |row| header << row.downcase.tr(' ', '_') }
      (2..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        new_row = eval("#{spreadsheet.default_sheet.singularize}").new(row)

        # Check existance on database, if the record already exist, destroy it with it's comment
        checker = eval("#{spreadsheet.default_sheet.singularize}").find(row['id'].to_i) rescue nil
        checker.destroy unless checker.nil?

        raise 'Failed to save, maybe invalid column' unless new_row.save!

        total_row += 1
      end
    end

    respond_to do |f|
      f.html { redirect_to articles_path, :notice => "Importing #{total_row} records successfully" }
    end
  end

  def open_spreadsheet(file)
    case File.extname(file.original_filename)
      when '.csv' then Roo::Csv.new(file.path, nil, :ignore)
      when '.xls' then Roo::Excel.new(file.path, nil, :ignore)
      when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
      else raise "Unknown file type: #{file.original_filename}"
    end
  end
   
  def new
    @article = Article.new
  end

  def show
    @article = Article.find_by_id(params[:id])
    #@comments = Article.find_by_id(params[:id]).comments
    @comments = @article.comments.order("id desc")
    @comment = Comment.new
  end

  def edit
    @article = Article.find_by_id(params[:id])
  end

  def create
    @article = Article.new(params_article)
    if @article.save
    flash[:notice] = "Success Add Records"
    #redirect_to action: 'index'
    redirect_to root_path
    else
      flash[:error] = "data not valid"
      render 'new'
    end
  end

  def update
    @article = Article.find_by_id(params[:id])

    if @article.update(params_article)
    flash[:notice] = "Success Update Records"
    redirect_to action: 'index'
    else
      flash[:error] = "data not valid"
      render 'edit'
    end
  end

  def destroy
    @article = Article.find_by_id(params[:id])

    if @article.destroy
    flash[:notice] = "Success Delete Records"
    redirect_to action: 'index'
    else
      flash[:error] = "fails delete a records"
      render 'edit'
    end
  end

  def params_article
    params.require(:article).permit(:title, :content, :status)
  end

end
