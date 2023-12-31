package com.example.user_management.repository;

import com.example.user_management.model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserRepository implements IUserRepository {
    private static BaseRepository baseRepository = new BaseRepository();
    //MySQL URL:
    private static final String SELECT_ALL_USERS = "SELECT * FROM users;";
    private static final String INSERT_USER = "INSERT INTO users (name, email, country) VALUES (?,?,?);";
    private static final String SELECT_USER_BY_ID = "SELECT * FROM users WHERE id = ?;";
    private static final String UPDATE_USER = "UPDATE users SET name = ?,email= ?, country =? WHERE id = ?;";
    private static final String DELETE_USER = "DELETE FROM users WHERE id = ?;";
    private static final String SELECT_BY_COUNTRY = "SELECT * FROM users WHERE country LIKE ?;";
    private static final String SORT_BY_NAME = "SELECT * FROM users ORDER BY name ASC;";
    private static final String CALL_SELECT_ALL = "CALL select_all();";
    private static final String CALL_UPDATE_USER = "CALL update_user(?,?,?,?);";
    private static final String CALL_DELETE_USER = "CALL delete_user(?);";

    @Override
    public List<User> selectAllUsers() {
        //Create list
        List<User> users = new ArrayList<>();
        //Step 1: Establish a Connection
        Connection connection = BaseRepository.getConnection();
        //Step 2: Create a statement using connection object
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS);
            //Step 3: Execute the query or update query
            ResultSet resultSet = preparedStatement.executeQuery();
            //Step 4: Process the ResultSet object and add to list
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");
                users.add(new User(id, name, email, country));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    @Override
    public void insertUser(User newUser) {
        Connection connection = BaseRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER);
            preparedStatement.setString(1, newUser.getName());
            preparedStatement.setString(2, newUser.getEmail());
            preparedStatement.setString(3, newUser.getCountry());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public User selectUser(int id) {
        User user = null;
        Connection connection = BaseRepository.getConnection();
        PreparedStatement preparedStatement = null;
        try {
            preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            preparedStatement.setInt(1, id);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");
                user = new User(id, name, email, country);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public boolean updateUser(User updatedUser) {
        boolean rowUpdated;
        Connection connection = BaseRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER);
            preparedStatement.setString(1, updatedUser.getName());
            preparedStatement.setString(2, updatedUser.getEmail());
            preparedStatement.setString(3, updatedUser.getCountry());
            preparedStatement.setInt(4, updatedUser.getId());
            rowUpdated = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return rowUpdated;
    }

    @Override
    public boolean deleteUser(int id) {
        boolean rowDeleted = false;
        Connection connection = BaseRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USER);
            preparedStatement.setInt(1, id);
            rowDeleted = preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }

    @Override
    public List<User> searchByCountry(String searchStr) {
        List<User> list = new ArrayList<>();
        String strSQL = "%" + searchStr + "%";

        Connection connection = BaseRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_BY_COUNTRY);
            preparedStatement.setString(1, strSQL);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");
                list.add(new User(id, name, email, country));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public List<User> sortByName() {
        List<User> list = new ArrayList<>();
        Connection connection = BaseRepository.getConnection();
        try {
            PreparedStatement preparedStatement = connection.prepareStatement(SORT_BY_NAME);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");
                list.add(new User(id, name, email, country));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public User getUserById(int id) {
        User user = null;
        String query = "CALL get_user_by_id (?);";
        //Step 1: Establishing the connection
        Connection connection = BaseRepository.getConnection();

        //Step 2: Create a statement using connection object
        try {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setInt(1, id);

            //Step 3: Execute query:
            ResultSet resultSet = callableStatement.executeQuery();

            //Step 4: Process the ResultSet:
            while (resultSet.next()) {
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");
                user = new User(id, name, email, country);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    @Override
    public void insertUserStore(User user) {
        //Make call query:
        String query = "CALL insert_user(?,?,?);";

        //Step 1: Establishing the connection
        Connection connection = BaseRepository.getConnection();

        //Step 2: CallableStatement
        try {
            CallableStatement callableStatement = connection.prepareCall(query);
            callableStatement.setString(1, user.getName());
            callableStatement.setString(2, user.getEmail());
            callableStatement.setString(3, user.getCountry());
            callableStatement.executeUpdate(); //Update
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<User> selectAllStored() {
        List<User> list = new ArrayList<>();
        Connection connection = BaseRepository.getConnection();
        try {
            CallableStatement callableStatement = connection.prepareCall(CALL_SELECT_ALL);
            ResultSet resultSet = callableStatement.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String name = resultSet.getString("name");
                String email = resultSet.getString("email");
                String country = resultSet.getString("country");
                list.add(new User(id, name, email, country));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public boolean updateUserStored(User updatedUser) {
        boolean rowUpdated = false;
        Connection connection = BaseRepository.getConnection();
        try {
            CallableStatement callableStatement = connection.prepareCall(CALL_UPDATE_USER);
            callableStatement.setString(1, updatedUser.getName());
            callableStatement.setString(2, updatedUser.getEmail());
            callableStatement.setString(3, updatedUser.getCountry());
            callableStatement.setInt(4, updatedUser.getId());
            rowUpdated = callableStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }

    public boolean deleteUserStored(int id) {
        boolean rowDeleted = false;
        Connection connection = BaseRepository.getConnection();
        try {
            CallableStatement callableStatement = connection.prepareCall(CALL_DELETE_USER);
            callableStatement.setInt(1, id);
            rowDeleted = callableStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowDeleted;
    }

}
