
package sample.bookings;

public class BookingError {
    private String duplicateBookedSlot;
    private String duplicateAcceptedRequest;
    private String overCapacity;

    public BookingError() {
        this.duplicateBookedSlot = "";
        this.duplicateAcceptedRequest = "";
        this.overCapacity = "";
    }

    public BookingError(String duplicateBookedSlot, String duplicateAcceptedRequest, String overCapacity) {
        this.duplicateBookedSlot = duplicateBookedSlot;
        this.duplicateAcceptedRequest = duplicateAcceptedRequest;
        this.overCapacity = overCapacity;
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
    
}
