
package sample.requests;

public class RequestError {
    private String currentDateError;
    private String endTimeError;
    private String durationError;
    private String duplicateRequestError;
    private String duplicateFreeSlotError;
    private String duplicateTimetableError;

    public RequestError() {
        this.currentDateError = "";
        this.endTimeError = "";
        this.durationError = "";
        this.duplicateRequestError = "";
        this.duplicateFreeSlotError = "";
        this.duplicateTimetableError = "";
    }

    public RequestError(String currentDateError, String endTimeError, String durationError, String duplicateRequestError, String duplicateFreeSlotError, String duplicateTimetableError) {
        this.currentDateError = currentDateError;
        this.endTimeError = endTimeError;
        this.durationError = durationError;
        this.duplicateRequestError = duplicateRequestError;
        this.duplicateFreeSlotError = duplicateFreeSlotError;
        this.duplicateTimetableError = duplicateTimetableError;
    }



    /**
     * @return the currentDateError
     */
    public String getCurrentDateError() {
        return currentDateError;
    }

    /**
     * @param currentDateError the currentDateError to set
     */
    public void setCurrentDateError(String currentDateError) {
        this.currentDateError = currentDateError;
    }

    /**
     * @return the endTimeError
     */
    public String getEndTimeError() {
        return endTimeError;
    }

    /**
     * @param endTimeError the endTimeError to set
     */
    public void setEndTimeError(String endTimeError) {
        this.endTimeError = endTimeError;
    }

    /**
     * @return the durationError
     */
    public String getDurationError() {
        return durationError;
    }

    /**
     * @param durationError the durationError to set
     */
    public void setDurationError(String durationError) {
        this.durationError = durationError;
    }

    /**
     * @return the duplicateRequestError
     */
    public String getDuplicateRequestError() {
        return duplicateRequestError;
    }

    /**
     * @param duplicateRequestError the duplicateRequestError to set
     */
    public void setDuplicateRequestError(String duplicateRequestError) {
        this.duplicateRequestError = duplicateRequestError;
    }

    /**
     * @return the duplicateTimetableError
     */
    public String getDuplicateTimetableError() {
        return duplicateTimetableError;
    }

    /**
     * @param duplicateTimetableError the duplicateTimetableError to set
     */
    public void setDuplicateTimetableError(String duplicateTimetableError) {
        this.duplicateTimetableError = duplicateTimetableError;
    }

    /**
     * @return the duplicateFreeSlotError
     */
    public String getDuplicateFreeSlotError() {
        return duplicateFreeSlotError;
    }

    /**
     * @param duplicateFreeSlotError the duplicateFreeSlotError to set
     */
    public void setDuplicateFreeSlotError(String duplicateFreeSlotError) {
        this.duplicateFreeSlotError = duplicateFreeSlotError;
    }
    
}
