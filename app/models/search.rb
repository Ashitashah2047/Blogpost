class Search < ApplicationRecord

    def search_posts

        posts = Post.all

        posts = posts.where(["title Like?", "%#{title}%"]) if title.present?
        posts = posts.where(["body Like?", body]) if body.present?
        posts = posts.where(["start_date Like?", start_date]) if start_date.present?
        posts = posts.where(["end_date Like?", end_date]) if end_date.present?

        return  posts

    end
end
