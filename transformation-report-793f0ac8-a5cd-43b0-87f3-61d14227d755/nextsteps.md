# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

The transformation appears to have completed successfully. There are no build errors present in the solution. The following steps outline how to validate, test, and deploy the migrated project.

## 1. Restore Dependencies

Run the following command from the solution root to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to package compatibility or deprecated packages targeting older frameworks.

## 2. Build the Solution

Perform a full build to confirm the absence of errors in a clean environment:

```bash
dotnet build --configuration Release
```

Address any warnings that surface during the build, particularly those related to nullable reference types or obsolete APIs, as these can indicate areas that may cause runtime issues.

## 3. Review Target Framework

Open `GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version (e.g., `net8.0`). Ensure it is not still referencing a Windows-only framework such as `net48` or `net472`.

## 4. Check for Windows-Specific Dependencies

Search the project for any remaining references to Windows-specific APIs or libraries, such as:

- `System.Web`
- `Microsoft.Web.*`
- Windows Registry access
- `HttpContext` usage from `System.Web` (should be replaced with `Microsoft.AspNetCore.Http`)

These will not cause build errors in all cases but can cause runtime failures on non-Windows platforms.

## 5. Run Unit Tests

If the solution contains test projects, execute them with:

```bash
dotnet test
```

Review test output carefully. Failures that did not exist prior to migration may indicate behavioral differences between the legacy framework and the new .NET runtime.

## 6. Run the Application Locally

Start the application using:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj
```

Manually verify the following:

- Application starts without exceptions
- Routing behaves as expected
- Database connections are established successfully
- Static files and views render correctly
- Authentication and session management function as intended

## 7. Review Configuration Files

Confirm that `appsettings.json` contains all necessary configuration values that were previously in `Web.config` or `App.config`. Key areas to check include:

- Connection strings
- Application settings
- Logging configuration
- Authentication settings

## 8. Validate Data Access Layer

If the project uses Entity Framework, confirm the version being used is compatible with the new target framework. Run any pending migrations:

```bash
dotnet ef database update
```

If the project uses a different ORM or raw ADO.NET, verify that connection strings and provider names are correctly configured for the new runtime.

## 9. Test on a Non-Windows Platform (Optional but Recommended)

If cross-platform support is a goal, run the application on Linux or macOS to surface any remaining platform-specific dependencies that were not caught during the build phase.

## 10. Publish the Application

Once validation is complete, publish the application using:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the output directory to confirm all required files are present, then deploy the contents to the target hosting environment.