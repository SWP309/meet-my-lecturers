
package sample.requests;

public class RequestError {
    private String duplicateBookedSlot;
    private String checkPassword;

    public RequestError() {
    }

    public RequestError(String duplicateBookedSlot, String checkPassword) {
        this.duplicateBookedSlot = duplicateBookedSlot;
        this.checkPassword = checkPassword;
    }

    /**
     * @return the checkPassword
     */
    public String getCheckPassword() {
        return checkPassword;
    }

    /**
     * @param checkPassword the checkPassword to set
     */
    public void setCheckPassword(String checkPassword) {
        this.checkPassword = checkPassword;
    }

    /**
     * @return the duplicateBookedSlot
     */
    public String getDuplicateBookedSlot() {
        return duplicateBookedSlot;
    }

    /**
     * @param duplicateBookedSlot the duplicateBookedSlot to set
     */
    public void setDuplicateBookedSlot(String duplicateBookedSlot) {
        this.duplicateBookedSlot = duplicateBookedSlot;
    }
    
}
