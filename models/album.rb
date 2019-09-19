require_relative('../db/sql_runner')

  class Album

    attr_reader(:album_id)
    attr_accessor(:title, :genre)


    def initialize(options)
      @album_id = options['album_id'].to_i if options['album_id']
      @title = options['title']
      @genre = options['genre']
      @artists_id = options['artists_id'].to_i
    end

    def save
      sql = "INSERT INTO albums (title, genre, artists_id)
      VALUES ($1, $2, $3) RETURNING album_id"
      values = [@title, @genre, @artists_id]
      new_album = SqlRunner.run(sql, values)
      @album_id = new_album[0]['album_id']
    end

    def Album.all
      sql = "SELECT * FROM albums"
      album_hash = SqlRunner.run(sql)
      albums = album_hash.map { |album| Album.new(album)}
      return albums
    end

    def Album.delete_all
      sql = "DELETE FROM albums"
      SqlRunner.run(sql)
    end

    # def Album.find(artists_id)
    #    sql = "SELECT * FROM albums
    #    WHERE artists_id = $1"
    #    values = [@artists_id]
    #    results = SqlRunner.run(sql, values)
    #    album = Album.new(results[0])
    #    return album
    # end

    def edit_album
      sql = "UPDATE albums SET name = $1, artist_id = $2, genre = $3 WHERE artists_id = $4"
      values = [@name, @artist_id, @genre, @artists_id]
      SqlRunner.run(sql, values)
    end

    def Album.delete_all
      sql = "DELETE FROM albums"
      SqlRunner.run(sql)
    end

    def Album.find_album_by_id(artists_id)
      sql = "SELECT * FROM albums WHERE artists_id = $1"
      values = [@album_id]
      result_array = SqlRunner.run(sql, values)
      album = Album.new(result_array[0])
      return album
    end



  end
