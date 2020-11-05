import User from '@models/userModel';

const getUsers = async (req, res) => {
    try {
        const result = await User.findAll({attributes: ['userId', 'profile_url']});
        
        return res.status(200).json({ data: result, message: "success" });
    } catch (error) {
        return res.status(400).json({ message: error.message });
    }
}

export default { getUsers };
