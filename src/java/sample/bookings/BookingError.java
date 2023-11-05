
package sample.bookings;

public class BookingError {
    private String duplicateBookedSlot;
    private String duplicateAcceptedRequest;
    private String overCapacity;
    private String checkPassword;

    public BookingError() {
        this.duplicateBookedSlot = "";
        this.duplicateAcceptedRequest = "";
        this.overCapacity = "";
        this.checkPassword = "";
    }

    public BookingError(String duplicateBookedSlot, String duplicateAcceptedRequest, String overCapacity, String checkPassword) {
        this.duplicateBookedSlot = duplicateBookedSlot;
        this.duplicateAcceptedRequest = duplicateAcceptedRequest;
        this.overCapacity = overCapacity;
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

    /**
     * @return the duplicateAcceptedRequest
     */
    public String getDuplicateAcceptedRequest() {
        return duplicateAcceptedRequest;
    }

    /**
     * @param duplicateAcceptedRequest the duplicateAcceptedRequest to set
     */
    public void setDuplicateAcceptedRequest(String duplicateAcceptedRequest) {
        this.duplicateAcceptedRequest = duplicateAcceptedRequest;
    }

    /**
     * @return the overCapacity
     */
    public String getOverCapacity() {
        return overCapacity;
    }

    /**
     * @param overCapacity the overCapacity to set
     */
    public void setOverCapacity(String overCapacity) {
        this.overCapacity = overCapacity;
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
    
}
