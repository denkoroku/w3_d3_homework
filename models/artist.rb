require_relative('../db/sql_runner')

  class Artist

    attr_reader(:artists_id)
    attr_accessor(:name)


    def initialize(options)
      @artists_id = options['artists_id'].to_i if options['artists_id']
      @name = options['name']
    end


    def save
      sql = "INSERT INTO artists (name)
      VALUES($1) RETURNING artists_id"
      values = [@name]
      new_artist = SqlRunner.run(sql, values)
      @artists_id = new_artist[0]['artists_id']
    end


    def Artist.all

      sql = "SELECT * FROM artists"
      artist_hash = SqlRunner.run(sql)
      artists = artist_hash.map { |artist| Artist.new(artist)}
      return artists

    end

    def list_by_artist
      sql = "SELECT * FROM albums WHERE artists_id =$1"
      values [@artists_id]
      album_hash = SqlRunner.run(sql, values)
      list = album_hash.map{ |album| Album.new(album)}
      return list
    end

    def edit_artist
      sql = "UPDATE artists SET name = $1 WHERE artists_id =$2"
      values = [@name, @artists_id]
      SqlRunner.run(sql, values)
    end

    def delete_artists
      sql = "DELETE FROM artists WHERE artists_id = $1"
      values = [@artists_id]
      SqlRunner.run(sql, values)
    end

    def Artist.find_artist_by_id(artists_id)
      sql = "SELECT * FROM artists WHERE artists_id = $1"
      values = [@artists_id]
      artists_list = SqlRunner.run(sql, values)
      artist_by_id = Artist.new(artists_list[0])
      return artist_by_id
    end

    def delete_all_artists
      sql = "DELETE FROM artists"
      SqlRunner.run(sql)
    end




end
