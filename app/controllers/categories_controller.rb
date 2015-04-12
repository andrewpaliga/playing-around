require 'rubygems'
require 'nokogiri'  
require 'open-uri'

class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :get_page]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    set_html_variables(@category.url)
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to action: 'show', id: @category.id }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  # GET /categories/1/pages/1
  def get_page
      set_html_variables(set_page_url(@category.url, params[:page]))
      respond_to do |format|
        format.html { render :layout => false }
        format.js
      end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.permit(:name, :url, :session)
    end

    def set_page_url(url, page)
      hash_num = url.to_s.split('/').last
      base_url = url.gsub(hash_num, "")
      new_url = base_url + "page-" + page.to_s + "/" + hash_num
    end

    def set_html_variables(url)
      page_content = Nokogiri::HTML(open(url))   
      @images = page_content.css("table.regular-ad img")
      @title = page_content.css("#SearchCategorySelected").text.titleize
      @ad_links = page_content.css("table.regular-ad")
    end
end
