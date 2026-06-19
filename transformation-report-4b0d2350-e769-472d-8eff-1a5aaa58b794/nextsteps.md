# Next Steps

## Issues resolved
- Transformed GadgetsOnline.csproj to net8.0

## Summary

The transformation appears to have completed successfully. No build errors were detected in any of the projects within the solution, including `GadgetsOnline/GadgetsOnline.csproj`.

## Validation Steps

### 1. Restore Dependencies

Run the following command from the root of the solution to ensure all NuGet packages are restored correctly:

```bash
dotnet restore
```

Review the output for any warnings related to missing packages or version conflicts.

### 2. Build the Solution

Perform a full build to confirm there are no compilation issues:

```bash
dotnet build --configuration Release
```

Confirm that the build output reports zero errors and review any warnings that may indicate deprecated APIs or compatibility concerns.

### 3. Review Target Framework

Open `GadgetsOnline/GadgetsOnline.csproj` and confirm the `<TargetFramework>` element is set to the intended cross-platform .NET version, for example:

```xml
<TargetFramework>net8.0</TargetFramework>
```

If the target framework does not match your intended version, update it accordingly and re-run the build.

### 4. Run Unit Tests

If the solution contains test projects, execute all tests to verify that existing functionality has not regressed:

```bash
dotnet test --configuration Release
```

Review the test results and investigate any failures.

### 5. Check for Removed or Changed APIs

Even with a clean build, some APIs behave differently on cross-platform .NET compared to .NET Framework. Pay particular attention to:

- **System.Web** dependencies, which are not available in cross-platform .NET and may have been replaced by ASP.NET Core equivalents.
- **Windows-specific APIs** such as the registry, WCF server-side components, or Windows Forms, if the project is intended to run on non-Windows platforms.
- **Configuration system changes**, migrating from `Web.config` or `App.config` to `appsettings.json` and the `Microsoft.Extensions.Configuration` stack.

### 6. Run the Application Locally

Start the application locally and exercise its primary workflows:

```bash
dotnet run --project GadgetsOnline/GadgetsOnline.csproj --configuration Release
```

Verify that all routes, data access operations, and business logic function as expected.

### 7. Review Static Files and Views

If this is a web project, confirm that static files, Razor views, or other content files are being served correctly. Check that file paths and case sensitivity are handled properly, as Linux-based systems are case-sensitive unlike Windows.

### 8. Validate Database Connectivity

If the project uses a database, confirm that connection strings in `appsettings.json` are correct and that any Entity Framework migrations are up to date:

```bash
dotnet ef database update --project GadgetsOnline/GadgetsOnline.csproj
```

### 9. Deploy to Target Environment

Once all local validation steps pass, deploy the application to your target environment using the publish command:

```bash
dotnet publish --configuration Release --output ./publish
```

Review the contents of the `./publish` directory and transfer them to your hosting environment according to your standard deployment process.