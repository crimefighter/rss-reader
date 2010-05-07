class FullTextSearch1273242891 < ActiveRecord::Migration
  def self.up
      ActiveRecord::Base.connection.execute(<<-'eosql')
        DROP index IF EXISTS entries_fts_idx
      eosql
      ActiveRecord::Base.connection.execute(<<-'eosql')
                CREATE index entries_fts_idx
        ON entries
        USING gin((to_tsvector('english', coalesce(entries.title, '') || ' ' || coalesce(entries.content, ''))))

      eosql
  end
end
