class BooksController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_book, {only:[:edit]}
	def create
		@user = User.find(current_user.id)
		@book = current_user.books.new(book_params)
		@books = Book.all
		if @book.save
			flash[:notice] = "You have creatad book successfully."
			redirect_to book_path(@book)
		else
			render :index
		end
	end
	def index
		@book_data = Book.ransack(params[:q])
		@books = @book_data.result(distinct: true).includes(:taggings,:user)
		@user = current_user
		@book = Book.new
	end

	def search
    	@book = Book.search(search_params)
    	@books = @book.result(distinct: true).includes(:taggings,:user)
  	end

	def show
		@user = Book.find(params[:id]).user
		@books = Book.all
		@book = Book.new
		@book_data = Book.find(params[:id])
	end
	def edit
		@book = Book.find(params[:id])
	end
	def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            flash[:notice] = "You have updated book successfully."
            redirect_to book_path(@book)
        else
            render :edit
        end
    end
    def destroy
        book = Book.find(params[:id])
        book.destroy
        redirect_to books_path
    end
	private
	def search_params
    	params.require(:q).permit(:title_cont, :body_cont)
  	end
    def book_params
        params.require(:book).permit(:title, :body, :user_id,:tag_list)
    end
    def authenticate_book
    	book = Book.find(params[:id])
    	if book.user_id != current_user.id
			redirect_to books_path
    	end
    end
end
