package io.confluent.eventsim

/**
  * Constants
  */
object Constants {
  val THREE_AM = 3 * 60 * 60
  val DEFAULT_DAMPING = 0.0625
  val DEFAULT_WEEKEND_DAMPING = 0.5
  val DEFAULT_WEEKEND_DAMPING_OFFSET = 6
  val DEFAULT_WEEKEND_DAMPING_SCALE = 6
  val SECONDS_PER_DAY = 24 * 60 * 60
  val SECONDS_PER_YEAR = SECONDS_PER_DAY * 365.25
  val MILLISECONDS_PER_YEAR = SECONDS_PER_YEAR * 1000
  val DEFAULT_SESSION_GAP = 30 * 60
  // 30 minutes, per IAB
  val DEFAULT_NEW_USER_AUTH = "Guest"
  val DEFAULT_NEW_USER_LEVEL = "Free"
}
